class SendDataJob < ApplicationJob
  queue_as :default

  require 'grpc'
  require 'json'
  require_relative '../../grpc/pm_app_services_pb'

  include PmApp

  def perform(data, asset_id, settings)
    stub = PMApp::Stub.new('localhost:50051', :this_channel_is_insecure)
    to_send = []
    data.each do |d|
      x = d.split(settings[:separator])
      to_send.append(DataPoint.new(data: x, id: asset_id.to_i, settings: settings.to_json.to_s))
    end
    stub.send_data(to_send)
  end
end
