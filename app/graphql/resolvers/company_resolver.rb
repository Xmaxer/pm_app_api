module Resolvers
  class CompanyResolver < Types::BaseResolverAuthenticable
    description "Gets the specific companies information"

    argument :company_id, Integer, required: true
    type Types::CustomTypes::CompanyTypes::CompanyType, null: true

    def resolve(company_id:)
      Company.find_by(id: company_id, deleted: false)
    end
  end
end