module Types
  module CustomTypes
    module CompanyTypes
      class CompanyArgumentType < BaseInputObject
        argument :id, ID, required: false, description: "The ID of the company that is being updated"
        argument :name, String, required: false, description: "The company's name"
        argument :description, String, required: false, description: "The company's description"
      end
    end
  end
end
