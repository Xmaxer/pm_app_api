class Company < ApplicationRecord
  after_create :create_default_role
  belongs_to :user
  has_many :api_keys
  has_many :company_roles
  has_many :assets
  has_many :user_company_roles
  has_many :users, -> (company) {unscope(:where).joins(sanitize_sql_array(["left join user_company_roles ON users.id = user_company_roles.user_id and user_company_roles.company_id = %s", company.id])).select("users.*")}

  validates :name, length: {maximum: 50, too_long: Constants::Errors::COMPANY_NAME_TOO_LONG_ERROR[:message]}, presence: {message: Constants::Errors::COMPANY_NAME_NOT_PRESENT_ERROR[:message]}
  validates :description, length: {maximum: 500, too_long: Constants::Errors::COMPANY_DESCRIPTION_TOO_LONG_ERROR[:message]}

  private

  def create_default_role
    role = self.company_roles.create(name: "Owner")
    role.user_company_roles.create(user_id: self.user_id, company_id: self.id)
  end
end
