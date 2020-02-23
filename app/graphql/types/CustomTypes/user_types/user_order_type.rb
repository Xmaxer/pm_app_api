module Types
  module CustomTypes
    module UserTypes
      class UserOrderType < BaseInputObject
        argument :by, Types::CustomTypes::UserTypes::UserOrderEnumType, required: true, description: "What to order the results by"
        argument :direction, Types::CustomTypes::GenericTypes::OrderEnumType, required: true, description: "Direction to order results by"
      end
    end
  end
end
