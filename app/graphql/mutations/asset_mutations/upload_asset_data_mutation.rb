module Mutations
  module AssetMutations
    class UploadAssetDataMutation < BaseMutationAuthenticable

      argument :files, [ApolloUploadServer::Upload], required: true
      argument :asset_id, ID, required: true
      argument :headers, [String], required: true
      argument :column_types, Types::CustomTypes::GenericTypes::ColumnTypesArgumentType, required: true

      field :success, Boolean, null: false

      def resolve(**args)
        files = args[:files]

        valid_file_types = %w(application/vnd.ms-excel .csv text/plain application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)

        files.each do |file|
          raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::FILE_NOT_VALID_ERROR) unless valid_file_types.include?(file.content_type)
        end

        # number_of_columns = 0
        #
        # File.foreach(file.to_io) do |line|
        #   split = line.strip.split
        #   number_of_columns = split.size
        #   raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::HEADERS_NOT_SET_ERROR) if split.size != args[:headers].size
        #   break
        # end
        #
        # defined = args[:column_types][:remove].size + args[:column_types][:labels].size + args[:column_types][:features].size
        # raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::COLUMNS_NOT_DEFINED_ERROR) if defined != number_of_columns

        asset = context[:current_user].assets.find_by(id: args[:asset_id])
        raise Exceptions::ExceptionHandler.to_graphql_execution_error(Constants::Errors::ASSET_NOT_FOUND_ERROR) if asset.nil?

        res = nil

        files.each do |file|
          res = asset.files.attach(io: file.to_io, filename: file.original_filename)
        end

        # SendToInfluxJob.perform_later(asset, args[:headers], args[:column_types].to_h)
        {success: !res.nil?}
      end
    end
  end
end
