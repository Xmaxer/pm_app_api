class CompanyRole < ApplicationRecord
  belongs_to :company
  has_many :user_company_roles
  before_validation :default_values
  validates :colour, format: {with: /#[0-9a-fA-F]{6}/, message: Constants::Errors::COMPANY_ROLE_COLOUR_INVALID_ERROR}
  validates :name, length: {maximum: 15, too_long: Constants::Errors::COMPANY_ROLE_NAME_TOO_LONG_ERROR}, allow_nil: true

  private

  def default_values
    self.colour = "#FFFFFF" if self.colour.nil?
  end
end
