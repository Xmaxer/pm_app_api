module Resolvers
  class AssetFilesResolver < Types::BaseResolverAuthenticable
    description "Gets the asset information"
    type Types::CustomTypes::AssetTypes::AssetFilesType, null: true

    def resolve
      asset = object
      return nil if asset.nil?
      files = asset.files.attachments.map {|e| {filename: e.filename.to_s, filesize: e.blob.byte_size}}
      total_size = files.reduce(0){|sum, e| sum + e[:filesize]}
      number_of_files = files.size
      {files: files, total_size: total_size, number_of_files: number_of_files}
    end
  end
end