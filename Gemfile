source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "4.2.4"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
# gem "coffee-rails", "~> 4.1.0"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"

gem "sidekiq"
# Materialize
gem "materialize-sass", "0.97.1"
gem "bourbon"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc

# Use ActiveModel has_secure_password
gem "omniauth-oauth2", "~> 1.3.1"
gem "bcrypt", "~> 3.1.7"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem "omniauth-google-oauth2"
gem "figaro"
gem "pry"
gem "rubocop", require: false

# Use Unicorn as the app server
# gem "unicorn"

# Use Capistrano for deployment
# gem "capistrano-rails", group: :development

group :development, :test do
  gem "byebug"
  gem "travis"
  gem "rspec-rails"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
  # Use sqlite3 as the database for Active Record
  gem "sqlite3"
end

group :production do
  gem "pg",             "0.17.1"
  gem "rails_12factor", "0.0.2"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
