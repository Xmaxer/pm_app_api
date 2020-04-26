module Types
  module CustomTypes
    module RoleTypes
      class RoleType < BaseObject
        field :id, ID, null: true, description: "The unique ID for the role"
        field :name, String, null: true
        field :colour, String, null: true
        field :number_of_users, resolver: Resolvers::RoleUsageResolver
      end
    end
  end
end
