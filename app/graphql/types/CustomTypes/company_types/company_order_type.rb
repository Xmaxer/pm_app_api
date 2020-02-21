module Types
  module CustomTypes
    module CompanyTypes
      class CompanyOrderType < BaseInputObject
        argument :by, Types::CustomTypes::CompanyTypes::CompanyOrderEnumType, required: true, description: "What to order the results by"
        argument :direction, Types::CustomTypes::GenericTypes::OrderEnumType, required: true, description: "Direction to order results by"
      end
    end
  end
end
