module Mutations
  module AssetMutations
    class DeleteAssetMutation < BaseMutationAuthenticable
      description "Deletes a specified asset."

      argument :id, ID, required: true, description: "Valid asset ID"

      field :asset, Types::CustomTypes::AssetTypes::AssetType, null: true, description: "The deleted asset, otherwise null"

      def resolve(**args)
        args[:user_id] = context[:current_user].id
        asset = Asset.find_by(id: args[:id])
        return {asset: asset} if !asset.nil? && asset.update_attribute(:deleted, true)
        {asset: nil}
      end
    end
  end
end
