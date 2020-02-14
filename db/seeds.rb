# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = []
(1..50).each { |i|
  user = User.new({first_name: "User " + i.to_s, last_name: "LUser " + i.to_s, password: "123456", password_confirmation: "123456", email: "user" + i.to_s + "@place.com", phone_number: "+3531111111" + i.to_s})
  user.save
  users.push(user)
}

companies = []
roles = []
(1..100).each { |i|
  user = users.sample
  company = user.companies.new({name: "Company " + i.to_s, description: "Description " + i.to_s})
  company.save
  companies.push(company)
  (1..rand(2..6)).each do |x|
    role = company.company_roles.new({name: "Role " + x.to_s, colour: "#FFFFFF"})
    role.save
    roles.push(role)
  end

}

assets = []
(1..500).each do |i|
  company = companies.sample
  asset = company.assets.new({name: "Asset " + i.to_s, description: "Asset desc", user_id: company.user_company_roles.sample.user_id})
  asset.save
  assets.push(asset)
end

(1...100).each do |i|
  user = users.sample
  role = roles.sample
  user_role = user.user_company_roles.new({company_role_id: role.id})
  user_role.save
  key = user.api_keys.new({name: "My Api key " + i.to_s, company_id: role.company.id})
  key.save
end



