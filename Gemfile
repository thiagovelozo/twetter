source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.0'
gem 'sass-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 3.0.0.0.rc'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'



group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'sqlite3'
end

group :production do
  gem "pg"
end

gem 'devise'

group :development, :test do
  # Use RSpec for testing: https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 2.0'
  # Use Factory Girl for Active Record sample instance object creation: https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
  gem 'factory_girl_rails'
  # Use FFaker for random seed generation: https://github.com/EmmanuelOga/ffaker
  gem 'ffaker', :require => false
  # Use Shoulda Matchers for validation and association testing: https://github.com/thoughtbot/shoulda-matchers
  gem 'shoulda-matchers'
end