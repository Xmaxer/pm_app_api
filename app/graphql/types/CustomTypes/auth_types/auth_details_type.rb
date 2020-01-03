module Types
  module CustomTypes
    module AuthTypes
      class AuthDetailsType < BaseInputObject
        argument :email, String, required: true, description: "A valid email"
        argument :password, String, required: true, description: "The password for the email user"
      end
    end
  end
end
