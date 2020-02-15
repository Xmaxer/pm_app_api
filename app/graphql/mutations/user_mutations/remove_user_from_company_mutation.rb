module Mutations
  module UserMutations
    class RemoveUserFromCompanyMutation < BaseMutationAuthenticable
      description "Adds a user to the company."

      argument :user_id, ID, required: true, description: "The user to remove from the company"
      argument :company_id, ID, required: true, description: "The company to remove the user from."
      argument :role_id, ID, required: false, description: "The specific role to remove"
      argument :purge, Boolean, required: false, description: "To completely remove the user or not from the company entirely"

      field :company, Types::CustomTypes::CompanyTypes::CompanyType, null: true, description: "The company the user was removed from"
      field :user, Types::CustomTypes::UserTypes::UserType, null: true, description: "The user that was removed from the company"
      field :success, Boolean, null: false, description: "Whether the action was successful or not"

      def resolve(**args)

        company = Company.find_by(id: args[:company_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_DOES_NOT_EXIST_ERROR) if company.nil?

        user = User.find_by(id: args[:user_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_DOES_NOT_EXIST_ERROR) if user.nil?

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_IS_COMPANY_OWNER_ERROR) if company.user_id == user.id

        if args[:purge]
          role = user.user_company_roles.find_by({company: company})
        else
          role = user.user_company_roles.find_by({company: company, company_role: args[:role_id]})
        end

        success = !role.nil?

        role.delete unless role.nil?

        {company: company, user: user, success: success}
      end
    end
  end
end
