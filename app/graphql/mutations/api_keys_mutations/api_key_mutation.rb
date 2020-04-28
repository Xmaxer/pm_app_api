module Mutations
  module ApiKeysMutations
    class ApiKeyMutation < BaseMutationAuthenticable
      description "Creates a new api key owned by the company."

      argument :api_key_details, Types::CustomTypes::ApiKeyTypes::ApiKeyArgumentType, required: true, description: "Valid api key details"

      field :api_key, Types::CustomTypes::ApiKeyTypes::ApiKeyType, null: true, description: "The newly created api key, null otherwise"

      def resolve(**args)
        user = context[:current_user]

        api_key = ApiKey.find_by(id: args[:api_key_details][:id])
        attrs = args[:api_key_details].to_h.except(:id, :company_id)
        if api_key.nil?
          company = user.companies.find_by(id: args[:api_key_details][:company_id])
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_DOES_NOT_EXIST_ERROR) if company.nil?
          attrs[:user_id] = user.id
          attrs[:company_id] = company.id
          api_key = ApiKey.new(attrs)
          updated = api_key.valid? && api_key.save
        else
          updated = api_key.update(attrs)
        end

        Exceptions::ExceptionHandler.to_graphql_execution_error_array(api_key.errors).each { |error| context.add_error(error) } unless updated
        return {api_key: nil} if api_key.id.nil?

        {api_key: api_key}
      end
    end
  end
end
