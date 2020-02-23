module Mutations
  module AuthenticationMutations
    class LogoutMutation < Mutations::BaseMutationAuthenticable
      description "Logout of the current session (Invalidates token)"
      field :success, Boolean, null: false, description: "True if logged out of current session"

      def resolve
        {success: Authentication::Authentication.logout(context[:current_user].current_token)}
      end
    end
  end
end
