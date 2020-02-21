module Types
  module CustomTypes
    module ApiKeyTypes
      class ApiKeysOrderType < BaseInputObject
        argument :by, Types::CustomTypes::ApiKeyTypes::ApiKeysOrderEnumType, required: true, description: "What to order the results by"
        argument :direction, Types::CustomTypes::GenericTypes::OrderEnumType, required: true, description: "Direction to order results by"
      end
    end
  end
end
