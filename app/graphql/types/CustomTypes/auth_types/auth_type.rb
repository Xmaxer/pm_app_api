module Types
  module CustomTypes
    module AuthTypes
      class AuthType < BaseObject
        field :token, String, null: false
      end
    end
  end
end
