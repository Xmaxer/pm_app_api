module Types
  module CustomTypes
    module CompanyTypes
      class CompanyType < BaseObject
        field :id, ID, null: false, description: "The unique ID for the company"
        field :name, String, null: false, description: "The company's name"
        field :description, String, null: true, description: "The company's description"
        field :dashboard_url, String, null: true, description: "Grafana dashboard url"
        field :grafana_username, String, null: true
        field :grafana_password, String, null: true
        field :number_of_assets, resolver: Resolvers::NumberOfAssetsResolver, null: false, description: "The number of assets the company has"
        field :assets, resolver: Resolvers::AssetsResolver
        field :users, resolver: Resolvers::UsersResolver
        field :total_size, resolver: Resolvers::TotalCompanyDataSizeResolver
      end
    end
  end
end
