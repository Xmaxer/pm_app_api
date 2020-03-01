class SendToInfluxJob < ApplicationJob
  queue_as :default
  require 'influxdb'

  def perform(asset, headers, column_types)
    puts "STARTING JOB"
    influx = InfluxDB::Client.new "asset_data", async: true
    c = 1
    asset.data.blob.open do |tempfile|
      File.foreach(tempfile.to_io) do |line|
        data = {
            values: Hash[headers.zip(line.strip.split)],
            tags: {id: c}
        }
        influx.write_point(asset.id.to_s, data)
        c += 1
      end
    end

    puts "ENDING JOB"
  end
end
