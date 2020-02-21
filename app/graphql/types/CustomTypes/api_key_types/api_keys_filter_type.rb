module Types
  module CustomTypes
    module ApiKeyTypes
      class ApiKeysFilterType < BaseInputObject
        argument :name_contains, String, required: false, description: "Name contains string criteria filter"
      end
    end
  end
end
