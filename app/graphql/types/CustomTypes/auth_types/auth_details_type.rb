module Types
  module CustomTypes
    module AuthTypes
      class AuthDetailsType < BaseInputObject
        argument :email, String, required: true
        argument :password, String, required: true
      end
    end
  end
end
