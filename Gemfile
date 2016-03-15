source "https://rubygems.org"
ruby "2.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "bourbon"
gem "cloudinary", "1.1.0"
gem "coveralls", require: false
gem "faye-websocket", "0.10.0"
# Use jquery as the JavaScript library
gem "jquery-rails"
gem "jquery-turbolinks"
gem "sidekiq"


# Materialize
gem "materialize-sass", "0.97.1"
gem "websocket-rails"


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc

# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
gem "omniauth-oauth2", "~> 1.3.1"
gem "omniauth-facebook"
gem "omniauth-twitter"
gem "omniauth-google-oauth2", "0.2.10"
gem "pg", "0.17.1"
gem "rails", "4.2.4"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "travis", "1.8.0"
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "database_cleaner"
  gem "pry"
  gem "pry-rails"
end

group :development do
  gem "web-console", "~> 2.0"
  gem "rubocop", require: false
  gem "figaro"
end

group :production do
  gem "rails_12factor", "0.0.2"
end

group :test do
  gem "shoulda-matchers", "~> 3.1"
  gem "factory_girl_rails"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
