module Types
  module CustomTypes
    module ApiKeyTypes
      class ApiKeyHistoryType < BaseObject
        field :id, ID, null: false
        field :query, ID, null: true
        field :created_at, ID, null: false
      end
    end
  end
end
