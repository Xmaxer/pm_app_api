module Types
  module CustomTypes
    module ApiKeyTypes
      class ApiKeyType < BaseObject
        field :id, ID, null: false, description: "The unique ID for the API key"
        field :name, String, null: false, description: "The API key's name"
        field :company_name, String, null: false, description: "The company the API key belongs to"
        field :api_key, String, null: false, description: "The API key"
        field :last_used, GraphQL::Types::ISO8601DateTime, null: true, description: "The time the API key was last used"
      end
    end
  end
end
