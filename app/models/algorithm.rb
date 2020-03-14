class Algorithm < ApplicationRecord
  belongs_to :asset
  has_one_attached :algorithm
end
