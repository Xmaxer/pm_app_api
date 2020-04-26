module Types
  module CustomTypes
    module RoleTypes
      class RoleArgumentType < BaseInputObject
        argument :company_id, ID, required: true
        argument :id, ID, required: false
        argument :name, String, required: false
        argument :colour, String, required: false
      end
    end
  end
end
