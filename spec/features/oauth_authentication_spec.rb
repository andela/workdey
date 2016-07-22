# frozen_string_literal: true
require "rails_helper"

RSpec.feature "Oauth Authentication" do
  let(:user_attr) { OmniAuth.config.mock_auth[:google_oauth2] }
  let(:buttons) { ["I need help with tasks", "I want to carry out tasks"] }

  before :all do
    Rails.application.env_config["omniauth.auth"] = OmniAuth.
                                                    config.
                                                    mock_auth[:google_oauth2]
  end

  context "when a user signs up" do
    scenario "user should be able to choose a role" do
      visit signin_path
      click_link "Google"
      expect(page).to have_content user_attr.info.name
      expect(page).to have_button buttons[0]
      expect(page).to have_button buttons[1]
    end
  end

  context "when a user logs in" do
    scenario "user should be redirected to the profile page" do
      User.first_or_create_from_oauth(user_attr).tap do |user|
        user.user_type = "tasker"
      end.save

      visit signin_path
      click_link "Google"

      expect(page).to have_content "Complete Your Profile"
      expect(page).to have_link user_attr.info.name
      click_on user_attr.info.name
      expect(page).to have_link "Sign Out"
      expect(page).to have_link "Edit Profile"
    end
  end
end
