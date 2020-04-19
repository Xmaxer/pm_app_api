module Types
  module CustomTypes
    module AssetTypes
      class AssetType < BaseObject
        field :id, ID, null: false, description: "The unique ID for the asset"
        field :name, String, null: false, description: "The asset's name"
        field :description, String, null: true, description: "The asset's description"
        field :files, resolver: Resolvers::AssetFilesResolver
        field :algorithm, resolver: Resolvers::AssetAlgorithmResolver
      end
    end
  end
end
