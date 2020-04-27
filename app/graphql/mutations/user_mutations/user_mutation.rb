module Mutations
  module UserMutations
    class UserMutation < BaseMutationAuthenticable

      argument :user_details, Types::CustomTypes::UserTypes::UserArgumentType, required: true

      field :user, Types::CustomTypes::UserTypes::UserType, null: true

      def resolve(**args)
        user = context[:current_user]
        attrs = args[:user_details].to_h.except(:new_password, :password)
        password = args[:user_details][:password]
        new_password = args[:user_details][:new_password]

        authenticated = user.authenticate(password)

        if authenticated
          unless new_password.nil?
            attrs[:password] = new_password
            attrs[:password_confirmation] = new_password
          end
          updated = user.update(attrs)
          Exceptions::ExceptionHandler.to_graphql_execution_error_array(user.errors).each { |error| context.add_error(error) } and return {user: nil} unless updated
          {user: user}
        else
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::AUTHENTICATION_PASSWORD_INVALID_ERROR)
        end
      end
    end
  end
end
