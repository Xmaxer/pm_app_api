module Types
  module CustomTypes
    module CompanyTypes
      class CompanyType < BaseObject
        field :id, ID, null: false, description: "The unique ID for the company"
        field :name, String, null: false, description: "The company's name"
        field :description, String, null: true, description: "The company's description"
      end
    end
  end
end
