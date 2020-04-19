module Types
  module CustomTypes
    module AssetTypes
      class AssetFilesDescriptorType < BaseObject
        field :filename, String, null: false, description: "The name of the file"
        field :filesize, Int, null: false, description: "The files size in bytes"
      end
    end
  end
end
