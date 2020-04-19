module Resolvers
  class AssetAlgorithmResolver < Types::BaseResolverAuthenticable
    description "Gets the algorithm name"
    type String, null: true

    def resolve
      asset = object
      return {asset: nil} if asset.nil?
      asset.algorithm[:name]
    end
  end
end