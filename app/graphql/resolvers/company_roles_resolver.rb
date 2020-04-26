module Resolvers
  class CompanyRolesResolver < Types::BaseResolverAuthenticable
    description "Gets the specific company's role information"

    type [Types::CustomTypes::RoleTypes::RoleType], null: false

    def resolve
      object.company_roles
    end
  end
end