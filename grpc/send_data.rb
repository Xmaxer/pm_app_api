# DEPRECATED

require 'grpc'
require_relative 'pm_app_services_pb'

include PmApp

stub = PMApp::Stub.new('localhost:50051', :this_channel_is_insecure)
require 'json'
stub.send_data(DataPoint.new(data: ARGV[1].split(ARGV[2]), id: ARGV[0].to_i, settings: JSON.generate(JSON.parse(ARGV[3].gsub('=>', ':')))))