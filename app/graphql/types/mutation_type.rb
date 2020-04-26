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
    field :add_role, mutation: Mutations::UserMutations::AddUserToCompanyMutation
    field :remove_role, mutation: Mutations::UserMutations::RemoveUserFromCompanyMutation
    field :upload_asset_data, mutation: Mutations::AssetMutations::UploadAssetDataMutation
    field :send_asset_data, mutation: Mutations::AssetMutations::SendDataMutation
    field :delete_api_key, mutation: Mutations::ApiKeysMutations::DeleteApiKeyMutation
    field :api_key, mutation: Mutations::ApiKeysMutations::ApiKeyMutation
    field :role, mutation: Mutations::RoleMutations::RoleMutation
    field :delete_role, mutation: Mutations::RoleMutations::DeleteRoleMutation
  end
end
