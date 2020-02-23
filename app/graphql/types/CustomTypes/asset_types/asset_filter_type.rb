module Types
  module CustomTypes
    module AssetTypes
      class AssetFilterType < BaseInputObject
        argument :name_contains, String, required: false, description: "Name contains string criteria filter"
      end
    end
  end
end
