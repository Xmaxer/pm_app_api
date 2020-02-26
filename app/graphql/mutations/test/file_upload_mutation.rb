module Mutations
  module Test
    class FileUploadMutation < BaseMutation

      argument :file, ApolloUploadServer::Upload, required: true
      field :success, Boolean, null: false

      def resolve(**args)
        asset = Asset.first
        res = asset.data.attach(io: args[:file].to_io, filename: args[:file].original_filename)
        {success: !res.nil?}
      end
    end
  end
end
