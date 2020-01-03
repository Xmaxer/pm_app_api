module Types
  module CustomTypes
    module CompanyTypes
      class CompanyArgumentType < BaseObject
        argument :name, String, required: true, description: "The company's name"
        argument :description, String, required: false, description: "The company's description"
      end
    end
  end
end
