module Resolvers
  class CompanyRoleResolver < Types::BaseResolverAuthenticable
    description "Gets the specific company's role information"

    type Types::CustomTypes::UserTypes::UserRoleType, null: true

    def resolve
      byebug
      object.joins("LEFT JOIN company_roles ON company_roles.id = user_company_roles.company_role_id").select("users.*, company_roles.name as name, company_roles.colour as colour")
    end
  end
end