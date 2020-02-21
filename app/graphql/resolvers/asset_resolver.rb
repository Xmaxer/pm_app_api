module Resolvers
  class AssetResolver < Types::BaseResolverAuthenticable
    description "Gets the asset information"

    argument :asset_id, Integer, required: true
    type Types::CustomTypes::AssetTypes::AssetType, null: true

    def resolve(asset_id:)
      Asset.find_by(id: asset_id, deleted: false)
    end
  end
end