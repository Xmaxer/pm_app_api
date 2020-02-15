module Mutations
  module UserMutations
    class AddUserToCompanyMutation < BaseMutationAuthenticable
      description "Adds a user to the company."

      argument :user_id, ID, required: true, description: "The user to add to the company"
      argument :company_id, ID, required: true, description: "The company to add the user to."
      argument :role_id, ID, required: false, description: "The role to automatically assign the user"

      field :company, Types::CustomTypes::CompanyTypes::CompanyType, null: true, description: "The company the user was added to"
      field :user, Types::CustomTypes::UserTypes::UserType, null: true, description: "The user that was added to the company"
      field :success, Boolean, null: false, description: "Whether the action was successful or not"

      def resolve(**args)
        company = Company.find_by(id: args[:company_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_DOES_NOT_EXIST_ERROR) if company.nil?

        user = User.find_by(id: args[:user_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::USER_DOES_NOT_EXIST_ERROR) if user.nil?

        role = nil
        role = CompanyRole.find_by(id: args[:role_id]) unless args[:role_id].nil?

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_ROLE_DOES_NOT_EXIST_ERROR) if role.nil? and !args[:role_id].nil?

        company_role = user.user_company_roles.new({company: company, company_role: role})

        success = company_role.valid?

        if success then company_role.save else Exceptions::ExceptionHandler.to_graphql_execution_error_array(company_role.errors).each { |error| context.add_error(error) } end

        {company: company, user: user, success: success}
      end
    end
  end
end
