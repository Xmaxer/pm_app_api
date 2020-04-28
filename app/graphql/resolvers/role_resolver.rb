module Resolvers
  class RoleResolver < Types::BaseResolverAuthenticable
    description "Gets the number of times this role was used"

    type [Types::CustomTypes::RoleTypes::RoleType], null: false
    def resolve
      object.company_roles.where(company_id: context.scoped_context[:company].id)
    end
  end
end
