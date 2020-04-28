class Company < ApplicationRecord
  after_create :create_default_role
  belongs_to :user
  has_many :api_keys
  has_many :company_roles
  has_many :assets
  has_many :user_company_roles
  has_many :users, through: :user_company_roles



  validates :name, length: {maximum: 50, too_long: Constants::Errors::COMPANY_NAME_TOO_LONG_ERROR[:message]}, presence: {message: Constants::Errors::COMPANY_NAME_NOT_PRESENT_ERROR[:message]}
  validates :description, length: {maximum: 500, too_long: Constants::Errors::COMPANY_DESCRIPTION_TOO_LONG_ERROR[:message]}

  def actual_users
    company = Company.find_by(id: self.id)
    User.where(id: company.users.ids, enabled: true).or(User.where(id: company.user.id, enabled: true))
  end

  private

  def create_default_role
    role = self.company_roles.create(name: "Owner")
    role.user_company_roles.create(user_id: self.user_id, company_id: self.id)
  end
end
