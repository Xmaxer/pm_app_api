module Types
  module CustomTypes
    module ApiKeyTypes
      class ApiKeyArgumentType < BaseInputObject
        argument :id, ID, required: false, description: "The api keys ID to edit"
        argument :company_id, ID, required: true, description: "A valid company ID"
        argument :name, String, required: true, description: "The api keys name"
      end
    end
  end
end
