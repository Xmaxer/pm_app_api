module Mutations
  module AssetMutations
    class UploadAssetDataMutation < BaseMutationAuthenticable

      argument :files, [ApolloUploadServer::Upload], required: true
      argument :asset_id, ID, required: true
      argument :headers, [String], required: true
      argument :column_types, Types::CustomTypes::GenericTypes::ColumnTypesArgumentType, required: true
      argument :separator, String, required: true

      field :success, Boolean, null: false

      def resolve(**args)
        files = args[:files]

        valid_file_types = %w(application/vnd.ms-excel .csv text/plain application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)

        files.each do |file|
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::FILE_NOT_VALID_ERROR) unless valid_file_types.include?(file.content_type)
        end
        
        asset = context[:current_user].assets.find_by(id: args[:asset_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::ASSET_NOT_FOUND_ERROR) if asset.nil?

        res = nil
        extra = !asset.files.attachments.empty?

        files.each do |file|
          res = asset.files.attach(io: file.to_io, filename: file.original_filename)
        end

        unless extra
          features = args[:column_types][:features]
          labels = args[:column_types][:labels]
          remove = args[:column_types][:remove]

          Algorithm.create({asset: asset, name: "Asset " + args[:asset_id].to_s + " algorithm", expected_features: features.size, settings: {features: features, to_ignore: remove, labels: labels, separator: args[:separator].to_s}}) if asset.algorithm.nil?
        end

        {success: !res.nil?}
      end
    end
  end
end
