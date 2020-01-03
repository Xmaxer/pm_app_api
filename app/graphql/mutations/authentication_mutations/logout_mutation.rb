module Mutations
  module AuthenticationMutations
    class LogoutMutation < Mutations::BaseMutationAuthenticable
      description "Logout of the current session (Invalidates token)"
      field :success, Boolean, null: false, description: "True if logged out of current session"

      def resolve
        user = context[:current_user]
        {success: Authentication::Authentication.logout(user.current_token, user.id)}
      end
    end
  end
end
