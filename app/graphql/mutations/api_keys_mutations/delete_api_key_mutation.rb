module Mutations
  module ApiKeysMutations
    class DeleteApiKeyMutation < BaseMutationAuthenticable
      description "Deletes a specified api key."

      argument :id, ID, required: true, description: "Valid api key ID"

      field :api_key, Types::CustomTypes::ApiKeyTypes::ApiKeyType, null: true, description: "The deleted api key, otherwise null"

      def resolve(**args)
        api_key = ApiKey.find_by(id: args[:id])
        return {api_key: context[:current_user].companies.joins(:api_keys).joins("left JOIN (select api_key_id, max(created_at) as last_used from api_key_histories group by api_key_id) as j on j.api_key_id = api_keys.id").select("api_keys.*, companies.name as company_name, j.last_used").where('api_keys.deleted = true and api_keys.id = ?', api_key.id).first} if !api_key.nil? && api_key.update_attribute(:deleted, true)
        {api_key: nil}
      end
    end
  end
end
