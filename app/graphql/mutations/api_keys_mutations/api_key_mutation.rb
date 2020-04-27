module Mutations
  module ApiKeysMutations
    class ApiKeyMutation < BaseMutationAuthenticable
      description "Creates a new api key owned by the company."

      argument :api_key_details, Types::CustomTypes::ApiKeyTypes::ApiKeyArgumentType, required: true, description: "Valid api key details"

      field :api_key, Types::CustomTypes::ApiKeyTypes::ApiKeyType, null: true, description: "The newly created api key, null otherwise"

      def resolve(**args)
        user = context[:current_user]
        company = user.companies.find_by(id: args[:api_key_details][:company_id])

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COMPANY_DOES_NOT_EXIST_ERROR) if company.nil?

        api_key = company.api_keys.find_by(id: args[:api_key_details][:id])
        attrs = args[:api_key_details].to_h.except(:id)
        if api_key.nil?
          attrs[:user_id] = user.id
          api_key = ApiKey.new(attrs)
          updated = api_key.valid? && api_key.save
        else
          updated = api_key.update(attrs)
        end

        Exceptions::ExceptionHandler.to_graphql_execution_error_array(api_key.errors).each { |error| context.add_error(error) } unless updated
        return {api_key: nil} if api_key.id.nil?

        {api_key: user.companies.joins(:api_keys).joins("left JOIN (select api_key_id, max(created_at) as last_used from api_key_histories group by api_key_id) as j on j.api_key_id = api_keys.id").select("api_keys.*, companies.name as company_name, j.last_used").where('api_keys.deleted = false and api_keys.id = ?', api_key.id).first}
      end
    end
  end
end
