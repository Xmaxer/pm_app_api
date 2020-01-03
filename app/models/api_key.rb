class ApiKey < ApplicationRecord
  belongs_to :user
  belongs_to :company
  has_secure_token :api_key

  validates :name, length: {maximum: 20, too_long: Constants::Errors::API_KEY_NAME_TOO_LONG_ERROR}, presence: {message: Constants::Errors::API_KEY_NAME_NOT_PRESENT_ERROR}
end
