# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retweet do
    tweet { FactoryGirl.create(:tweet) }
    user { FactoryGirl.create(:user) }
  end
end
