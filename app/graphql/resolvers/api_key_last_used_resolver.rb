module Resolvers
  class ApiKeyLastUsedResolver < Types::BaseResolverAuthenticable

    type GraphQL::Types::ISO8601DateTime, null: true

    def resolve
      history = ApiKeyHistory.where(api_key_id: object.id).order(created_at: :desc).first
      return history[:created_at] unless history.nil?
      nil
    end
  end
end
