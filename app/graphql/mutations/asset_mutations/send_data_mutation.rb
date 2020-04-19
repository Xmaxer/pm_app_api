module Mutations
  module AssetMutations
    class SendDataMutation < BaseMutationApiAuth
      description "Sends a datapoint related to the asset"

      argument :asset_id, ID, required: true, description: "Valid asset ID"
      argument :data, [String], required: true, description: "Array of CSV data"
      field :success, Boolean, null: false, description: "Whether or not the data was sent successfully"

      def resolve(**args)
        company = object
        asset = company.assets.find_by(id: args[:asset_id])

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::ASSET_NOT_FOUND_ERROR) if asset.nil?

        algorithm = asset.algorithm

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::ALGORITHM_NOT_FOUND_ERROR) if algorithm.nil?
        separator = algorithm[:settings].to_h["separator"]
        args[:data].each do |d|
          size = d.strip.split(separator).size
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::WRONG_NUMBER_OF_FEATURES_ERROR) if size < algorithm[:expected_features]
        end

        SendDataJob.perform_later(args[:data], args[:asset_id], algorithm[:settings].to_h)
        {success: true}
      end
    end
  end
end
