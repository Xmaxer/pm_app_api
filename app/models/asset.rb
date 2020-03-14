class Asset < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_one :algorithm
  has_many_attached :files
  validates :name, length: {maximum: 50, too_long: Constants::Errors::ASSET_NAME_TOO_LONG_ERROR}, presence: {message: Constants::Errors::ASSET_NAME_NOT_PRESENT_ERROR}
  validates :description, length: {maximum: 500, too_long: Constants::Errors::ASSET_DESCRIPTION_TOO_LONG_ERROR}
end
