module Types
  module CustomTypes
    module ApiKeyTypes
      class ApiKeyType < BaseObject
        field :id, ID, null: false, description: "The unique ID for the API key"
        field :name, String, null: false, description: "The API key's name"
        field :company_name, resolver: Resolvers::ApiKeyCompanyNameResolver
        field :api_key, String, null: false, description: "The API key"
        field :last_used, resolver: Resolvers::ApiKeyLastUsedResolver
        field :history, resolver: Resolvers::ApiKeyHistoryResolver
      end
    end
  end
end
