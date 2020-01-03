module Mutations
  module AuthenticationMutations
    class LoginMutation < BaseMutation

      description "Login with valid credentials, returns a valid token if successful."

      argument :auth_details, Types::CustomTypes::AuthTypes::AuthDetailsType, required: true, description: "Credentials"

      field :token, String, null: false, description: "A valid token"

      def resolve(auth_details:)

        user = User.find_by(email: auth_details[:email])

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::AUTHENTICATION_EMAIL_INVALID_ERROR) unless user
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::AUTHENTICATION_PASSWORD_INVALID_ERROR) unless user.authenticate(auth_details[:password])

        {token: Authentication::Authentication.get_token(user)}
      end
    end
  end
end
