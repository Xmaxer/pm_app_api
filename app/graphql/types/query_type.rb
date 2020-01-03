module Types
  class QueryType < Types::BaseObject
    description "All query types. Query type documentation is under the query."
    field :user, resolver: Resolvers::UserResolver
  end
end
