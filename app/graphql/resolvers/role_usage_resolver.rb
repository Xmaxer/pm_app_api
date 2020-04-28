module Resolvers
  class RoleUsageResolver < Types::BaseResolverAuthenticable
    description "Gets the number of times this role was used"

    type Int, null: false
    def resolve
      context.scoped_context[:company].user_company_roles.where(id: object.id).count
    end
  end
end
