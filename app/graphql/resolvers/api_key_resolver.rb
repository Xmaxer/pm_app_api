module Resolvers
  class ApiKeyResolver < Types::BaseResolverAuthenticable
    description "Gets the specific companies information"

    argument :id, ID, required: true
    type Types::CustomTypes::ApiKeyTypes::ApiKeyType, null: true

    def resolve(id:)
      ApiKey.find_by(id: id)
    end
  end
end