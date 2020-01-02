module Mutations
  module AuthenticationMutations
    class LogoutAllMutation < Mutations::BaseMutationAuthenticable
      field :success, Boolean, null: false

      def resolve
        {success: Authentication::Authentication.logout_all(context[:current_user]) }
      end
    end
  end
end
