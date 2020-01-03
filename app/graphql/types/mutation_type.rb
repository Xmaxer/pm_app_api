module Types
  class MutationType < Types::BaseObject
    description "All the mutation. Mutations often make changes to data, all descriptions of each mutation is under the mutation type."
    field :login, mutation: Mutations::AuthenticationMutations::LoginMutation
    field :logout, mutation: Mutations::AuthenticationMutations::LogoutMutation
    field :register, mutation: Mutations::AuthenticationMutations::RegisterMutation
    field :logout_all, mutation: Mutations::AuthenticationMutations::LogoutAllMutation
  end
end
