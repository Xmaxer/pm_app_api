module Mutations
  module AssetMutations
    class CreateAssetMutation < BaseMutationAuthenticable
      description "Creates a new asset owned by the company."

      argument :name, Types::CustomTypes::AssetTypes::AssetArgumentType, required: true, description: "Valid asset details"

      field :asset, Types::CustomTypes::AssetTypes::AssetType, null: true, description: "The newly created asset, null otherwise"
      def resolve(**args)
        args[:user_id] = context[:current_user].id
        asset = Asset.new(args)
        return {asset: asset} if asset.valid? && asset.save
        Exceptions::ExceptionHandler.to_graphql_execution_error_array(asset.errors).each { |error| context.add_error(error)}
        {asset: nil}
      end
    end
  end
end
