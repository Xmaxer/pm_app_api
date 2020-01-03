# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.new({first_name: "Kevin", last_name: "Jakubauskas", password: "123456", password_confirmation: "123456", email: "some@place.com", phone_number: "+35311111111"})
user1.save

company1 = user1.companies.new({name: "Company 1", description: "Descp 1"})
company1.save

asset1 = company1.assets.new({name: "Asset 1", description: "Asset desc", user_id: user1.id})
asset1.save

role1 = company1.company_roles.new({name: "Role 1", colour: "xyz"})
role1.save

user_role1 = user1.user_company_roles.new({company_role_id: role1.id})
user_role1.save

key1 = user1.api_keys.new({name: "My Api key", company_id: company1.id})
key1.save

