Rails.application.routes.draw do
  post "/api", to: "graphql#execute"
    #get "/asset_algorithm/:asset_id", to: 'file_downloader#download'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
