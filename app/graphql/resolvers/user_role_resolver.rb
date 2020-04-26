module Resolvers
  class UserRoleResolver < Types::BaseResolverAuthenticable
    description "Gets the specific company's role information"

    type Types::CustomTypes::RoleTypes::RoleType, null: true

    def resolve
      object.joins("LEFT JOIN company_roles ON company_roles.id = user_company_roles.company_role_id").select("users.*, company_roles.name as name, company_roles.colour as colour")
    end
  end
end