module Types
  class MutationType < Types::BaseObject
    description "All the mutations. Mutations often make changes to data, all descriptions of each mutation is under the mutation type."
    field :login, mutation: Mutations::AuthenticationMutations::LoginMutation
    field :logout, mutation: Mutations::AuthenticationMutations::LogoutMutation
    field :register, mutation: Mutations::AuthenticationMutations::RegisterMutation
    field :logout_all, mutation: Mutations::AuthenticationMutations::LogoutAllMutation
    field :company, mutation: Mutations::CompanyMutations::CompanyMutation
    field :asset, mutation: Mutations::AssetMutations::AssetMutation
    field :delete_asset, mutation: Mutations::AssetMutations::DeleteAssetMutation
    field :delete_company, mutation: Mutations::CompanyMutations::DeleteCompanyMutation
  end
end
