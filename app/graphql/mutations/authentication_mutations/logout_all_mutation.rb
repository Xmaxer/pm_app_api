module Mutations
  module AuthenticationMutations
    class LogoutAllMutation < Mutations::BaseMutationAuthenticable
      description "Logout of all devices"
      field :success, Boolean, null: false, description: "True if logged out of all devices"

      def resolve
        {success: Authentication::Authentication.logout_all(context[:current_user]) }
      end
    end
  end
end
