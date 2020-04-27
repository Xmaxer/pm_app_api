module Grafana
  class GrafanaApi
    class << self
      require "uri"
      require "net/http"
      require 'json'

      def create_dashboard(company)

        url = URI("http://localhost:3000/api/dashboards/db")

        http = Net::HTTP.new(url.host, url.port)
        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = ["application/json", "text/plain"]
        request["Accept"] = "application/json"
        request["Authorization"] = "Bearer " + ENV["GRAFANA_API_KEY"].to_s
        request.body = "{\r\n  \"dashboard\": {\r\n    \"id\": null,\r\n    \"uid\": null,\r\n    \"title\": \"#{company.name} #{company.id}\"\r\n  },\r\n  \"overwrite\": false\r\n}"

        response = http.request(request)
        response = JSON.parse(response.read_body)
        dashboard_id = response["id"]
        return false if dashboard_id.nil?
        dashboard_url = response["url"]
        company.update_attribute(:dashboard_url, dashboard_url) unless company.nil?
        user_id = create_user(company)
        update_permissions(dashboard_id, user_id)
      end

      def create_user(company)
        auth = ENV["GRAFANA_ADMIN_USERNAME"].to_s + ":" + ENV["GRAFANA_ADMIN_PASSWORD"].to_s
        auth = Base64.strict_encode64(auth)
        url = URI("http://localhost:3000/api/admin/users")
        password = "password"
        http = Net::HTTP.new(url.host, url.port)
        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = ["application/json", "text/plain"]
        request["Accept"] = "application/json"
        request["Authorization"] = "Basic #{auth}"
        unique_name = (company.name.to_s + company.id.to_s).gsub("\s", "").downcase
        request.body = "{\r\n  \"name\": \"#{company.name}\",\r\n  \"email\": \"#{unique_name}@localhost\",\r\n  \"login\": \"#{unique_name}\",\r\n  \"password\": \"#{password}\"\r\n}"

        response = http.request(request)
        response = JSON.parse(response.read_body)
        user_id = response["id"]
        company.update(grafana_username: unique_name, grafana_password: password) unless user_id.nil?
        user_id
      end

      def update_permissions(dashboard_id, user_id)

        url = URI("http://localhost:3000/api/dashboards/id/#{dashboard_id}/permissions")

        http = Net::HTTP.new(url.host, url.port)
        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = ["application/json", "text/plain"]
        request["Accept"] = "application/json"
        request["Authorization"] = "Bearer " + ENV["GRAFANA_API_KEY"].to_s
        request.body = "{\r\n  \"items\": [\r\n  \t{\r\n  \t\t\"userId\": #{user_id},\r\n  \t\t\"permission\": 1\r\n  \t}\r\n  \t]\r\n}"

        response = http.request(request)
        response = JSON.parse(response.read_body)
        response["message"] == "Dashboard permissions updated"

      end
    end
  end
end