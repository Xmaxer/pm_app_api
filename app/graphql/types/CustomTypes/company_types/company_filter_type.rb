module Types
  module CustomTypes
    module CompanyTypes
      class CompanyFilterType < BaseInputObject
        argument :name_contains, String, required: false, description: "Name contains string criteria filter"
      end
    end
  end
end
