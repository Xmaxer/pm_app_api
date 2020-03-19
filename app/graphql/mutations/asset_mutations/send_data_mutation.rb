module Mutations
  module AssetMutations
    class SendDataMutation < BaseMutationAuthenticable
      description "Sends a datapoint related to the asset"

      argument :asset_id, ID, required: true, description: "Valid asset ID"
      argument :data, [String], required: true, description: "Array of CSV data"
      field :success, Boolean, null: false, description: "Whether or not the data was sent successfully"

      def resolve(**args)
        #raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::WRONG_FEATURE_FORMAT_ERROR) if args[:data].is_a? Array

        user = context[:current_user]
        asset = user.assets.find_by(id: args[:asset_id])

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::ASSET_NOT_FOUND_ERROR) if asset.nil?

        algorithm = asset.algorithm
        separator = algorithm[:settings].to_h["separator"]

        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::ALGORITHM_NOT_FOUND_ERROR) if algorithm.nil?

        args[:data].each do |d|
          size = d.split(separator).size
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::WRONG_NUMBER_OF_FEATURES_ERROR) if size < algorithm[:expected_features]
        end

        # stub = PMApp::Stub.new('localhost:50051', :this_channel_is_insecure)

        args[:data].each do |d|
          #stub.send_data(DataPoint.new(asset_id: args[:asset_id], data: d))
          %x(ruby #{Rails.root.to_s}/grpc/send_data.rb "#{args[:asset_id]}" "#{d.sub('"', "'")}" "#{separator}" '#{algorithm[:settings].to_s}')
        end

        {success: true}
      end
    end
  end
end
