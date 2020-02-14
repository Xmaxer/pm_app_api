module Mutations
  module CompanyMutations
    class DeleteCompanyMutation < BaseMutationAuthenticable
      description "Deletes a specified company."

      argument :id, ID, required: true, description: "Valid company ID"

      field :company, Types::CustomTypes::CompanyTypes::CompanyType, null: true, description: "The deleted company, otherwise null"

      def resolve(**args)
        args[:user_id] = context[:current_user].id
        company = Company.find_by(id: args[:id])

        #Ensure user is TRUE company owner (Regardless of role)
        if !company.nil? and company.user_id != args[:user_id]
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_COMPANY_OWNER)
        end
        return {company: company} if !company.nil? && company.update_attribute(:deleted, true)
        {company: nil}
      end
    end
  end
end
