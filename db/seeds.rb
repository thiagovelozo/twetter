=begin

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
20.times do |number|
  user = User.create!(username: "user#{number}", email: Faker::Internet.email, name: Faker::Name.name, password: "password")
end


=end