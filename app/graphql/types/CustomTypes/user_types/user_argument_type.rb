module Types
  module CustomTypes
    module UserTypes
      class UserArgumentType < BaseInputObject
        argument :first_name, String, required: false
        argument :last_name, String, required: false
        argument :phone_number, String, required: false
        argument :enabled, Boolean, required: false
        argument :password, String, required: true
        argument :new_password, String, required: false
        argument :email, String, required: false
      end
    end
  end
end
