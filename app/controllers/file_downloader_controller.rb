class FileDownloaderController < ApplicationController
  def download
    #a.algorithm.attach(io: file, filename: "test_algorithm.h5")
    #Rails.application.routes.url_helpers.polylmorphic_url(a.algorithm, only_path: true, disposition: 'attachment')
    redirect_to Rails.application.routes.url_helpers.rails_blob_path(Asset.find(params[:asset_id]).algorithm.algorithm, only_path: true, disposition: 'attachment')
  end
end
