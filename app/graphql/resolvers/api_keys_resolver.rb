module Resolvers
  class ApiKeysResolver < Types::BaseResolverAuthenticable
    require 'search_object'
    require 'search_object/plugin/graphql'
    include SearchObject.module(:graphql)

    def initialize(**args)
      raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless args[:context][:current_user]
      super(args)
    end


    description "Gets a list of API keys accessible to the user"

    scope { context[:current_user].companies.joins(:api_keys).joins("left JOIN (select api_key_id, max(created_at) as last_used from api_key_histories group by api_key_id) as j on j.api_key_id = api_keys.id").select("api_keys.*, companies.name as company_name, j.last_used").where('api_keys.deleted = false') }

    option :filter, type: Types::CustomTypes::ApiKeyTypes::ApiKeysFilterType, with: :apply_filter
    option :order, type: Types::CustomTypes::ApiKeyTypes::ApiKeysOrderType, default: {by: "ID", direction: "DESC"}, with: :apply_order
    option :first, type: Int, default: 10, with: :apply_first
    option :skip, type: Int, default: 0, with: :apply_skip

    type [Types::CustomTypes::ApiKeyTypes::ApiKeyType], null: true

    def apply_order(scope, value)
      scope.order(value[:by].downcase.to_sym => value[:direction].downcase.to_sym)
    end

    def apply_filter(scope, value)
      scope = scope.where('name LIKE ?', value[:name_contains]) if value[:name_contains]
      scope
    end

    def apply_first(scope, value)
      scope.limit(if value < 1 or value > 20
                    10
                  else
                    value
                  end)
    end

    def apply_skip(scope, value)
      scope.offset(if value < 1
                     0
                   else
                     value
                   end)
    end
  end
end