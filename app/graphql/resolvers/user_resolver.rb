module Resolvers
  class UserResolver < Types::BaseResolverAuthenticable
    description "Gets the currently logged in users details, useful for authentication test."
    type Types::CustomTypes::UserTypes::UserType, null: true

    def resolve
        context[:current_user]
    end
  end
end