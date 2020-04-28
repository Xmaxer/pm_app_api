module Resolvers
  class CompanyRolesResolver < Types::BaseResolverAuthenticable
    description "Gets the specific company's role information"

    type [Types::CustomTypes::RoleTypes::RoleType], null: false

    def resolve
      context.scoped_context[:company] = object
      object.company_roles
    end
  end
end