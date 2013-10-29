twitter-clone
=============

This is the sample Twitter Clone code base for Thinkful's Ruby on Rails course.

Before Beginning
-------------

Ensure you have the latest version of Ruby Version Manager (RVM) and ruby 2.0.0-p247 installed.

```sh
# If you do not have RVM installed, you can do so as follows
\curl -L https://get.rvm.io | bash -s stable

# If you already have RVM install, make sure it's up to date
rvm get head # rvm update for older versions

# Install the most recent Ruby 2.0.0 package
rvm install ruby-2.0.0
```

Getting Started
-------------

```sh
# Clone the repository
git clone git@github.com:bluefocus/twitter-clone.git

cd ./twitter-clone

# Install the required gems
bundle install

# Generate a new config/initializers/secret_token.rb file.
echo "TwitterClone::Application.config.secret_key_base = '`bundle exec rake secret`'" > config/initializers/secret_token.rb

# Set up the database
bundle exec rake db:create db:migrate db:test:prepare

# Start the server
bundle exec rails s
```

Once you've performed the above actions, you can view the website at http://localhost:3000.
Start by creating a user for yourself and then consider using the rake tasks below to seed
additional test data.

Seeds
-------------

```sh
bundle exec rake seed:users             # Create 20 users
bundle exec rake seed:tweets            # Create 5 tweets for each user
```

If you'd like to log in as one of your recently seeded users, use the rails console to
set the user's password.

```sh
bundle exec rails c
```

```ruby
user = User.find_by_username('<@username for the user>')
user.password = 'temp1234'
user.save
user.email
# => dmatthews@thinkful.com
exit
```

Now you can use the email address displayed and password to log in as this user.

Run the Tests
-------------

```sh
bundle exec rspec
```
