module Types
  module CustomTypes
    module UserTypes
      class RegisterArgumentType < BaseInputObject
        argument :password, String, required: true, description: "A secure password"
        argument :password_confirmation, String, required: true, description: "Confirmation of password (Should be identical to password)"
        argument :email, String, required: true, description: "A valid email"
        argument :first_name, String, required: true, description: "The person's first name. Something to identify quick by"
        argument :last_name, String, required: false, description: "The person's last name. Not required, but preferred"
        argument :phone_number, String, required: false, description: "A valid phone number"
      end
    end
  end
end
