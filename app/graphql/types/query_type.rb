module Types
  class QueryType < Types::BaseObject
    description "All query types. Query type documentation is under the query."
    field :user, resolver: Resolvers::UserResolver
    field :company, resolver: Resolvers::CompanyResolver
    field :asset, resolver: Resolvers::AssetResolver
    field :is_authenticated, resolver: Resolvers::AuthenticatedResolver
    field :companies, resolver: Resolvers::CompaniesResolver
    field :api_keys, resolver: Resolvers::ApiKeysResolver
    field :assets, resolver: Resolvers::AssetsResolver
    field :users, resolver: Resolvers::UsersResolver
    field :api_key, resolver: Resolvers::ApiKeyResolver
  end
end
