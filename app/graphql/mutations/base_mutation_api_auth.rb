module Mutations
  class BaseMutationApiAuth < BaseMutation

    def initialize(object:, context:, field:)
      unless context[:api_key].nil?
        object = context[:api_key].company
      end
      super(object: object, context: context, field: field)
      raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless context[:api_key]

    end

  end
end

