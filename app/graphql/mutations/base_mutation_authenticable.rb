module Mutations
  class BaseMutationAuthenticable < BaseMutation

    def initialize(object:, context:, field:)
      super(object: object, context: context, field: field)
      raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless context[:current_user]
    end

  end
end

