module Mutations
  module AuthenticationMutations
    class LoginMutation < BaseMutation

      argument :auth_details, Types::CustomTypes::AuthTypes::AuthDetailsType, required: true

      field :auth_details, String, null: false

      def resolve(auth_details:)

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::EMAIL_REQUIRED_ERROR) if auth_details[:email].nil?

        user = User.find_by(email: auth_details[:email])

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::EMAIL_INVALID_ERROR) unless user
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::PASSWORD_INVALID_ERROR) unless user.authenticate(auth_details[:password])

        {auth_details: Authentication::Authentication.get_token(user)}
      end
    end
  end
end
