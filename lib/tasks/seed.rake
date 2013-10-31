require 'ffaker'

namespace :seed do
  desc "Create 5 twets for each user"
  task :twets => :environment do
    User.find_each do |user|
      5.times do
        Twet.create(:user => user, :content => Faker::Lorem.sentence(3))
      end
    end
  end

  desc "Create 20 users"
  task :users => :environment do
    20.times do
      User.create!(:email => Faker::Internet.email, :name => Faker::Name.name, :password => Faker.bothify("####????##??"), :username => Faker::Name.first_name)
    end
  end
end
