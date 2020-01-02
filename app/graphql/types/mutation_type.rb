module Types
  class MutationType < Types::BaseObject
    field :login, mutation: Mutations::AuthenticationMutations::LoginMutation
    field :logout, mutation: Mutations::AuthenticationMutations::LogoutMutation
    field :register, mutation: Mutations::AuthenticationMutations::RegisterMutation
    field :logout_all, mutation: Mutations::AuthenticationMutations::LogoutAllMutation
  end
end
