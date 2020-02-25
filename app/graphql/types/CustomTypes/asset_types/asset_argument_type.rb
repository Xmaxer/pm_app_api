module Types
  module CustomTypes
    module AssetTypes
      class AssetArgumentType < BaseInputObject
        argument :company_id, ID, required: true, description: "A valid company ID"
        argument :name, String, required: true, description: "The asset's name"
        argument :id, ID, required: false, description: "The asset's ID if modifying"
        argument :description, String, required: false, description: "The asset's description"
      end
    end
  end
end
