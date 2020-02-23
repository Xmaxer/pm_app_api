module Types
  module CustomTypes
    module AssetTypes
      class AssetOrderType < BaseInputObject
        argument :by, Types::CustomTypes::AssetTypes::AssetOrderEnumType, required: true, description: "What to order the results by"
        argument :direction, Types::CustomTypes::GenericTypes::OrderEnumType, required: true, description: "Direction to order results by"
      end
    end
  end
end
