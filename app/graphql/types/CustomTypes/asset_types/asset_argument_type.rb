module Types
  module CustomTypes
    module AssetTypes
      class AssetArgumentType < BaseObject
        argument :company_id, required: true, description: "A valid company ID"
        argument :name, String, required: true, description: "The asset's name"
        argument :description, String, required: false, description: "The asset's description"
      end
    end
  end
end
