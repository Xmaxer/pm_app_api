module Mutations
  module AuthenticationMutations
    class LogoutMutation < Mutations::BaseMutationAuthenticable
      field :success, Boolean, null: false

      def resolve
        user = context[:current_user]
        {success: Authentication::Authentication.logout(user.current_token, user.id)}
      end
    end
  end
end
