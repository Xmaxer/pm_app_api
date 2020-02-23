class UserCompanyRole < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :company_role

  validates :user_id, uniqueness: {scope: [:company_id, :company_role_id]}
end
