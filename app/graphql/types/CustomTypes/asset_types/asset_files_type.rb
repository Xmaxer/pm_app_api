module Types
  module CustomTypes
    module AssetTypes
      class AssetFilesType < BaseObject
        field :files, [Types::CustomTypes::AssetTypes::AssetFilesDescriptorType], null: false, description: "The name of the file"
        field :total_size, Int, null: false, description: "The files size in bytes"
        field :number_of_files, Int, null: false, description: "The number of files"
      end
    end
  end
end
