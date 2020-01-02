class UserCompanyRole < ApplicationRecord
  belongs_to :company_roles
  belongs_to :users
end
