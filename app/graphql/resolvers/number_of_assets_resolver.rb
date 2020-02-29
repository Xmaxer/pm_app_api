module Resolvers
  class NumberOfAssetsResolver < Types::BaseResolverAuthenticable

    type Int, null: false

    def resolve
      object.nil? ? 0 : object.assets.where(deleted: false).count
    end
  end
end