module Resolvers
  class CompanyResolver < Types::BaseResolverAuthenticable
    description "Gets the specific companies information"

    argument :company_id, ID, required: true
    type Types::CustomTypes::CompanyTypes::CompanyType, null: true

    def resolve(company_id:)
      company = context[:current_user].companies.where(id: company_id, deleted: false).select("companies.*, COUNT(assets.id) as number_of_assets").left_outer_joins(:assets).group(:id).first
      Grafana::GrafanaApi.create_dashboard(company) if !company.nil? and company[:dashboard_url].nil?
      if company.nil? then nil else company end
    end
  end
end