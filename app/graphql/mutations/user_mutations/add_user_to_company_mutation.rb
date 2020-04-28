module Mutations
  module UserMutations
    class AddUserToCompanyMutation < BaseMutationAuthenticable
      description "Adds a user to the company."

      argument :user_id, ID, required: true, description: "The user to add to the company"
      argument :company_id, ID, required: true, description: "The company to add the user to."
      argument :role_ids, [ID], required: true, description: "The role to automatically assign the user"

      field :company, Types::CustomTypes::CompanyTypes::CompanyType, null: true, description: "The company the user was added to"
      field :user, Types::CustomTypes::UserTypes::UserType, null: true, description: "The user that was added to the company"
      field :success, Boolean, null: false, description: "Whether the action was successful or not"

      def resolve(**args)
        company = Company.find_by(id: args[:company_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_DOES_NOT_EXIST_ERROR) if company.nil?

        user = User.find_by(id: args[:user_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_DOES_NOT_EXIST_ERROR) if user.nil?

        roles = []

        args[:role_ids].each do |role_id|
          role = CompanyRole.find_by(id: role_id)
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_ROLE_DOES_NOT_EXIST_ERROR) if role.nil?
          roles.append(role)
        end

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_ROLE_DOES_NOT_EXIST_ERROR) if roles.empty?
        success = false
        roles.each do |role|
          company_role = user.user_company_roles.new({company: company, company_role: role})
          success = company_role.valid? && company_role.save
          Exceptions::ExceptionHandler.to_graphql_execution_error_array(company_role.errors).each { |error| context.add_error(error) } and break unless success
        end
        context.scoped_context[:company] = company
        {company: company, user: user, success: success}
      end
    end
  end
end
