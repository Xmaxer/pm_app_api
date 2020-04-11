module Grafana
  class GrafanaAPI

    require "uri"
    require "net/http"
    require 'json'

    def create_dashboard(company_name, company_id)

      url = URI("localhost:3000/api/dashboards/db")

      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = ["application/json", "text/plain"]
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer " + ENV("GRAFANA_API_KEY")
      request.body = "{\r\n  \"dashboard\": {\r\n    \"id\": null,\r\n    \"uid\": null,\r\n    \"title\": \"#{company_name} #{company_id}\"\r\n  },\r\n  \"overwrite\": false\r\n}"

      response = http.request(request)
      response = JSON.parse(response.read_body)
      dashboard_id = response["id"]
      return false if dashboard_id.nil?
      dashboard_url = response["url"]
      company = Company.find_by(id: company_id)
      company.update_attribute(:dashboard_url, dashboard_url) unless company.nil?
      user_id = create_user(company_name, (company_name.to_s + company_id.to_s).gsub("\s", "").downcase, company)
      update_permissions(dashboard_id, user_id)
    end

    def create_user(username, login, company)

      url = URI("localhost:3000/api/admin/users")
      password = "password"
      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = ["application/json", "text/plain"]
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer " + ENV("GRAFANA_API_KEY")
      request.body = "{\r\n  \"name\": \"#{username}\",\r\n  \"email\": \"default@localhost\",\r\n  \"login\": \"#{login}\",\r\n  \"password\": \"#{password}\"\r\n}"

      response = http.request(request)
      response = JSON.parse(response.read_body)
      user_id = response["id"]
      company.update_attributes(grafana_username: login, grafana_password: password) unless user_id.nil?
      user_id
    end

    def update_permissions(dashboard_id, user_id)

      url = URI("localhost:3000/api/dashboards/id/#{dashboard_id}/permissions")

      http = Net::HTTP.new(url.host, url.port)
      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = ["application/json", "text/plain"]
      request["Accept"] = "application/json"
      request["Authorization"] = "Bearer " + ENV("GRAFANA_API_KEY")
      request.body = "{\r\n  \"items\": [\r\n  \t{\r\n  \t\t\"userId\": #{user_id},\r\n  \t\t\"permission\": 1\r\n  \t}\r\n  \t]\r\n}"

      response = http.request(request)
      response = JSON.parse(response.read_body)
      response.code == "200"

    end
  end
end