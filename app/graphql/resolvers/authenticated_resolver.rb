module Resolvers
    class AuthenticatedResolver < Types::BaseResolver

      description "Checks whether the login token is valid or not. Include the authorization header."

      type Boolean, null: false

      def resolve
        !context[:current_user].nil?
      end
    end
end
