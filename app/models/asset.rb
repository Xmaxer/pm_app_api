class Asset < ApplicationRecord
  belongs_to :company

  validates :name, length: {maximum: 50, too_long: Constants::Errors::ASSET_NAME_TOO_LONG_ERROR}, presence: {message: Constants::Errors::ASSET_NAME_NOT_PRESENT_ERROR}
  validates :description, length: {maximum: 500, too_long: Constants::Errors::ASSET_DESCRIPTION_TOO_LONG_ERROR}
end
