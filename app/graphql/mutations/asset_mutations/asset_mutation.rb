module Mutations
  module AssetMutations
    class AssetMutation < BaseMutationAuthenticable
      description "Creates a new asset owned by the company."

      argument :asset_details, Types::CustomTypes::AssetTypes::AssetArgumentType, required: true, description: "Valid asset details"

      field :asset, Types::CustomTypes::AssetTypes::AssetType, null: true, description: "The newly created asset, null otherwise"

      def resolve(**args)
        args[:user_id] = context[:current_user].id
        asset = Asset.find_or_initialize_by(id: args[:asset_details][:id])
        attrs = args[:asset_details]
        if asset.new_record?
          attrs[:user_id] = args[:user_id]
          asset = Asset.new(attrs)
        else
          asset.attributes = attrs
        end
        return {asset: asset} if asset.valid? && asset.save
        Exceptions::ExceptionHandler.to_graphql_execution_error_array(asset.errors).each { |error| context.add_error(error) }
        {asset: nil}
      end
    end
  end
end
