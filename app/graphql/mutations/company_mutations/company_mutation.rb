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
        else
          company.attributes = attrs
        end
        return {company: company} if company.valid? && company.save
        Exceptions::ExceptionHandler.to_graphql_execution_error_array(company.errors).each { |error| context.add_error(error) }
        {company: nil}
      end
    end
  end
end
