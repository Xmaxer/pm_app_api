module Resolvers
  class ApiKeyHistoryResolver < Types::BaseResolverAuthenticable
    description "Gets the specific Api keys history"

    type [Types::CustomTypes::ApiKeyTypes::ApiKeyHistoryType], null: true

    def resolve
      object.api_key_histories
    end
  end
end