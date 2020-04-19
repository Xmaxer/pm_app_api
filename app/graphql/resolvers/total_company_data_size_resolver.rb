module Resolvers
  class TotalCompanyDataSizeResolver < Types::BaseResolverAuthenticable
    description "Get total data size"
    type Int, null: false

    def resolve
      company = object
      return 0 if company.nil?
      company.assets.reduce(0) {|sum, e| sum + e.files.attachments.reduce(0) {|sum2, x| sum2 + x.blob.byte_size}}
    end
  end
end