module Mutations
  module CompanyMutations
    class CompanyMutation < BaseMutationAuthenticable
      description "Creates a new company owned by the user."

      argument :company_details, Types::CustomTypes::CompanyTypes::CompanyArgumentType, required: true, description: "Valid company details"

      field :company, Types::CustomTypes::CompanyTypes::CompanyType, null: true, description: "The newly created company, null otherwise"

      def resolve(**args)
        args[:user_id] = context[:current_user].id
        company = Company.find_or_initialize_by(id: args[:company_details][:id])
        attrs = args[:company_details].to_h.except(:id)
        if company.new_record?
          attrs[:user_id] = args[:user_id]
          company = Company.new(attrs)
          updated = company.valid? && company.save
        else
          updated = company.update(attrs)
        end

        Exceptions::ExceptionHandler.to_graphql_execution_error_array(company.errors).each { |error| context.add_error(error) } unless updated
        return {company: nil} if company.id.nil?

        if company[:dashboard_url].nil?
          success = Grafana::GrafanaApi.create_dashboard(company)
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::GRAFANA_DASHBOARD_FAILED) unless success
        end
        {company: Company.find_by(id: company.id)}
      end
    end
  end
end
