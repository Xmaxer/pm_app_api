module Resolvers
  class AssetAlgorithmResolver < Types::BaseResolverAuthenticable
    description "Gets the algorithm name"
    type String, null: true

    def resolve
      asset = object
      return {asset: nil} if asset.nil?
      if asset.algorithm.nil? then nil else asset.algorithm[:name] end
    end
  end
end