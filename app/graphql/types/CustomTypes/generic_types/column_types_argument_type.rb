module Types
  module CustomTypes
    module GenericTypes
      class ColumnTypesArgumentType < BaseInputObject
        argument :remove, [Int], required: true, description: "The columns to mark for ignore"
        argument :labels, [Int], required: true, description: "The columns to mark as labels"
        argument :features, [Int], required: true, description: "The columns to mark as features"
      end
    end
  end
end
