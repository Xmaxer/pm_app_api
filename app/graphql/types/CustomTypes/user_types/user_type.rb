module Types
  module CustomTypes
    module UserTypes
      class UserType < BaseObject
        field :id, ID, null: false
        field :first_name, String, null: false
        field :last_name, String, null: true
        field :email, String, null: false
      end
    end
  end
end
