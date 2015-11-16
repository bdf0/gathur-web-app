# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(first_name:  "Example", last_name: "User", 
             email: "example@railstutorial.org", phone: "4445556666",
             password:              "foobar",
             password_confirmation: "foobar", admin: true)

99.times do |n|
  name  = Faker::Name.name.split
  first_name = name[0]
  last_name = name[1]
  email = "example-#{n+1}@railstutorial.org"
  phone = "#{5553330000 + n}"
  password = "password"
  User.create!(first_name:  first_name, last_name: last_name, 
               email: email, phone: phone, 
               password:              password,
               password_confirmation: password)
end