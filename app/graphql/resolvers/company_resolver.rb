module Resolvers
  class CompanyResolver < Types::BaseResolverAuthenticable
    description "Gets the specific companies information"

    argument :company_id, Integer, required: true
    type Types::CustomTypes::CompanyTypes::CompanyType, null: true

    def resolve(company_id:)
      company = Company.where(id: company_id, deleted: false).select("companies.*, COUNT(assets.id) as number_of_assets").left_outer_joins(:assets).group(:id)
      if company.nil? or company.empty? then nil else company[0] end
    end
  end
end