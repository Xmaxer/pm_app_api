module Resolvers
  class UsersResolver < Types::BaseResolverAuthenticable
    require 'search_object'
    require 'search_object/plugin/graphql'
    include SearchObject.module(:graphql)

    def initialize(**args)
      raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::NOT_AUTHENTICATED_ERROR) unless args[:context][:current_user]
      super(args)
    end


    description "Gets a list of users belonging to a company"

    option :filter, type: Types::CustomTypes::UserTypes::UserFilterType, with: :apply_filter
    option :order, type: Types::CustomTypes::UserTypes::UserOrderType, default: {by: "ID", direction: "DESC"}, with: :apply_order
    option :first, type: Int, default: 10, with: :apply_first
    option :skip, type: Int, default: 0, with: :apply_skip
    option :company_id, type: ID, with: :by_company

    scope do
      object.nil? ? User.all : object.users.joins("LEFT JOIN company_roles ON company_roles.id = user_company_roles.company_role_id").select("users.*, json_agg(company_roles) as roles").group(:id)
    end

    type [Types::CustomTypes::UserTypes::UserType], null: true

    def by_company(scope, value)
      object.nil? ? scope.where(company_id: value) : nil
    end

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