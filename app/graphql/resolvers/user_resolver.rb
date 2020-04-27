module Resolvers
  class UserResolver < Types::BaseResolverAuthenticable
    description "Gets the currently logged in users details, useful for authentication test."
    argument :id, ID, required: false
    type Types::CustomTypes::UserTypes::UserType, null: true

    def resolve(**args)
      return User.find_by(id: args[:id]) if args[:id]
      context[:current_user]
    end
  end
end