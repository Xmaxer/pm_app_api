module Resolvers
  class AssetResolver < Types::BaseResolverAuthenticable
    description "Gets the asset information"

    argument :asset_id, Integer, required: true
    type Types::CustomTypes::CompanyTypes::CompanyType, null: true

    def resolve(company_id:)
      Company.find_by(id: company_id)
    end
  end
end