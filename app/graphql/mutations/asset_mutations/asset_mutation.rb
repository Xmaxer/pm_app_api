module Mutations
  module AssetMutations
    class AssetMutation < BaseMutationAuthenticable
      description "Creates a new asset owned by the company."

      argument :asset_details, Types::CustomTypes::AssetTypes::AssetArgumentType, required: true, description: "Valid asset details"

      field :asset, Types::CustomTypes::AssetTypes::AssetType, null: true, description: "The newly created asset, null otherwise"

      def resolve(**args)
        args[:user_id] = context[:current_user].id
        asset = Asset.find_by(id: args[:asset_details][:id])
        attrs = args[:asset_details].to_h.except(:id, :company_id)
        if asset.nil?
          attrs[:user_id] = args[:user_id]
          attrs[:company_id] = args[:asset_details][:company_id]
          asset = Asset.new(attrs)
          updated = asset.valid? && asset.save
        else
          updated = asset.update(attrs)
        end
        return {asset: asset} if updated
        Exceptions::ExceptionHandler.to_graphql_execution_error_array(asset.errors).each { |error| context.add_error(error) }
        {asset: nil}
      end
    end
  end
end
