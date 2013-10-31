# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :twet do
    user { FactoryGirl.create(:user) }
    content { Faker::Lorem.sentence(3) }
  end
end
