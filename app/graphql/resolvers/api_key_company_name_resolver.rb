module Resolvers
  class ApiKeyCompanyNameResolver < Types::BaseResolverAuthenticable

    type String, null: true

    def resolve
      object.company.name
    end
  end
end
