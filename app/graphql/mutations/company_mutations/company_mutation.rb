module Mutations
  module CompanyMutations
    class CompanyMutation < BaseMutationAuthenticable
      description "Creates a new company owned by the user."

      argument :company_details, Types::CustomTypes::CompanyTypes::CompanyArgumentType, required: true, description: "Valid company details"

      field :company, Types::CustomTypes::CompanyTypes::CompanyType, null: true, description: "The newly created company, null otherwise"

      def resolve(**args)


        dashboard_url = response["url"]

        args[:user_id] = context[:current_user].id
        company = Company.find_or_initialize_by(id: args[:company_details][:id])
        attrs = args[:company_details].to_h.except(:id)
        if company.new_record?
          attrs[:user_id] = args[:user_id]
          attrs[:dashboard_url] = dashboard_url
          company = Company.new(attrs)
        else
          company.attributes = attrs
        end

        Exceptions::ExceptionHandler.to_graphql_execution_error_array(company.errors).each { |error| context.add_error(error) } unless company.valid? && company.save
        return {company: nil} if company.id.nil?

        success = Grafana::GrafanaAPI.create_dashboard(company.name, company.id)
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::GRAFANA_DASHBOARD_FAILED) unless success

        {company: company}
      end
    end
  end
end
