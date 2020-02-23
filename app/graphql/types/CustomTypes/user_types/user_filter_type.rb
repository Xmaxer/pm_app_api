module Types
  module CustomTypes
    module UserTypes
      class UserFilterType < BaseInputObject
        argument :name_contains, String, required: false, description: "Name contains string criteria filter"
      end
    end
  end
end
