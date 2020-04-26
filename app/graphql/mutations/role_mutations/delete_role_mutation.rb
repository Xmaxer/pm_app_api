module Mutations
  module RoleMutations
    class DeleteRoleMutation < BaseMutationAuthenticable
      description "Deletes a specified role."

      argument :id, ID, required: true, description: "Valid role ID"

      field :role, Types::CustomTypes::RoleTypes::RoleType, null: true, description: "The deleted role, otherwise null"

      def resolve(**args)
        role = CompanyRole.find_by(id: args[:id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_ROLE_DOES_NOT_EXIST_ERROR) if role.nil?
        role.destroy
        {role: role}
      end
    end
  end
end
