module Mutations
  module AssetMutations
    class UploadAssetDataMutation < BaseMutationAuthenticable

      argument :file, ApolloUploadServer::Upload, required: true
      argument :asset_id, ID, required: true

      field :success, Boolean, null: false

      def resolve(**args)
        file = args[:file]
        valid_file_types = %w(application/vnd.ms-excel .csv text/plain application/vnd.openxmlformats-officedocument.spreadsheetml.sheet)
        return {success: false} unless valid_file_types.include?(file.content_type)
        asset = context[:current_user].assets.find_by(id: args[:asset_id])
        return {success: false} if asset.nil?
        res = asset.data.attach(io: args[:file].to_io, filename: file.original_filename)
        {success: !res.nil?}
      end
    end
  end
end
