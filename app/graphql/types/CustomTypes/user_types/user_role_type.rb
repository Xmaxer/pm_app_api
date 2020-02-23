module Types
  module CustomTypes
    module UserTypes
      class UserRoleType < BaseObject
        field :id, ID, null: true, description: "The unique ID for the role"
        field :name, String, null: true
        field :colour, String, null: true
      end
    end
  end
end
