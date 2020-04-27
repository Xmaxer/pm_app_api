module Mutations
  module RoleMutations
    class RoleMutation < BaseMutationAuthenticable

      argument :role_details, Types::CustomTypes::RoleTypes::RoleArgumentType, required: false

      field :role, Types::CustomTypes::RoleTypes::RoleType, null: true

      def resolve(**args)
        role = CompanyRole.find_by(id: args[:role_details][:id])

        attrs = args[:role_details].to_h.except(:id)
        if role.nil?
          attrs[:company_id] = args[:role_details][:company_id]
          role = CompanyRole.new(attrs)
          updated = role.valid? && role.save
        else
          updated = role.update(attrs)
        end

        Exceptions::ExceptionHandler.to_graphql_execution_error_array(role.errors).each { |error| context.add_error(error) } unless updated
        return {company: nil} if role.id.nil?
        {role: role}
      end
    end
  end
end
