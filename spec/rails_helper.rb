# This file is copied to spec/ when you run "rails generate rspec:install"
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../config/environment", __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "spec_helper"
require "rspec/rails"
require "capybara/rspec"
require "capybara/rails"
require "database_cleaner"
require "em_helper"
require "transactional_capybara/rspec"
OmniAuth.config.test_mode = true
facebook_authenticator = {
  "provider" => "facebook",
  "uid" => Faker::Number.number(5),
  "info" => {
    "name" => "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    "email" => Faker::Internet.free_email,
    "image" => Faker::Avatar.image
  }
}
google_authenticator = {
  provider: "google_oauth2",
  uid: Faker::Number.number(5),
  info: {
    name: "#{Faker::Name.first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.safe_email,
    image: Faker::Avatar.image
  }
}
OmniAuth.config.add_mock(:google_oauth2, google_authenticator)
OmniAuth.config.add_mock(:facebook, facebook_authenticator)

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

RSpec.configure do |config|
  Shoulda::Matchers.configure do |config|
    config.integrate do |with|
      with.test_framework :rspec

      with.library :active_record
      with.library :active_model
      with.library :action_controller
      with.library :rails
    end
  end
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = false
  config.before(:suite) { DatabaseCleaner.clean_with :truncation }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each) { DatabaseCleaner.strategy = :truncation }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
  config.include FactoryGirl::Syntax::Methods

  config.after(:each, js: true) do
   TransactionalCapybara::AjaxHelpers.wait_for_ajax(page)
 end

  config.infer_spec_type_from_file_location!
  config.include ApplicationControllerSpecHelper, type: :controller
end

include Helpers
