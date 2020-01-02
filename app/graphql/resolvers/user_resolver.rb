module Resolvers
  class UserResolver < Types::BaseResolverAuthenticable

    type Types::CustomTypes::UserTypes::UserType, null: true

    def resolve
        context[:current_user]
    end
  end
end