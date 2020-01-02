module Mutations
  module AuthenticationMutations
    class RegisterMutation < BaseMutation

      argument :user_details, Types::CustomTypes::UserTypes::RegisterArgumentType, required: true

      field :user, Types::CustomTypes::UserTypes::UserType, null: true

      def resolve(user_details:)
        user = User.new(user_details.to_h)
        if user.valid? && user.save
          return {user: user}
        end
        Exceptions::ExceptionHandler.to_graphql_execution_error_array(user.errors).each {|error| context.add_error(error)}
        {user: nil}
      end
    end
  end
end
