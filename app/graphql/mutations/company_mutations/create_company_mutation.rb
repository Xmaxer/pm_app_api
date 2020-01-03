module Mutations
  module CompanyMutations
    class CreateCompanyMutation < BaseMutationAuthenticable
      description "Creates a new company owned by the user."

      argument :name, Types::CustomTypes::CompanyTypes::CompanyArgumentType, required: true, description: "Valid company details"

      field :company, Types::CustomTypes::CompanyTypes::CompanyType, null: true, description: "The newly created company, null otherwise"
      def resolve(**args)
        args[:user_id] = context[:current_user].id
        company = Company.new(args)
        return {company: company} if company.valid? && company.save
        Exceptions::ExceptionHandler.to_graphql_execution_error_array(company.errors).each { |error| context.add_error(error)}
        {company: nil}
      end
    end
  end
end
