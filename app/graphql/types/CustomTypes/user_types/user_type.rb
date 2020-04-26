module Types
  module CustomTypes
    module UserTypes
      class UserType < BaseObject
        field :id, ID, null: false, description: "The unique ID for the user"
        field :first_name, String, null: false, description: "The user's first name"
        field :last_name, String, null: true, description: "The user's last name."
        field :email, String, null: false, description: "The user's registered email address."
        field :phone_number, String, null: true, description: "The user's phone number"
        field :companies, [Types::CustomTypes::CompanyTypes::CompanyType], null: true, description: "All the user companies"
        field :roles, [Types::CustomTypes::RoleTypes::RoleType], null: true
      end
    end
  end
end
