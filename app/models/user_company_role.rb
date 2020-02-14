class UserCompanyRole < ApplicationRecord
  belongs_to :user
  belongs_to :company
  belongs_to :company_role
end
