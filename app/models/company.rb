class Company < ApplicationRecord
  belongs_to :user
  has_many :api_keys
  has_many :company_roles
  has_many :assets

  validates :name, length: {maximum: 50, too_long: Constants::Errors::COMPANY_NAME_TOO_LONG_ERROR}, presence: {message: Constants::Errors::COMPANY_NAME_NOT_PRESENT_ERROR}
  validates :description, length: {maximum: 500, too_long: Constants::Errors::COMPANY_DESCRIPTION_TOO_LONG_ERROR}
end
