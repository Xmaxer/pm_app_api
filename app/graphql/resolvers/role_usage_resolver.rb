module Resolvers
  class RoleUsageResolver < Types::BaseResolverAuthenticable
    description "Gets the number of times this role was used"

    type Int, null: false
    def resolve
      object.user_company_roles.count
    end
  end
end
