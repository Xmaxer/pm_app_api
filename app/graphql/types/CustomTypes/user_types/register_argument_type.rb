module Types
  module CustomTypes
    module UserTypes
      class RegisterArgumentType < BaseInputObject
        argument :password, String, required: true
        argument :password_confirmation, String, required: true
        argument :email, String, required: true
        argument :first_name, String, required: true
        argument :last_name, String, required: false
        argument :phone_number, String, required: false
      end
    end
  end
end
