require "rails_helper"

RSpec.feature "OmniauthSignins", type: :feature do
  before(:all) do
    Capybara.default_driver = :selenium
    @user_attributes = OmniAuth.config.mock_auth[:facebook]
    Rails.application.env_config["omniauth.auth"] = @user_attributes
  end

  context "when user is not registered before" do
    scenario "user should be able to select his role" do
      visit signin_path
      expect(page).to have_no_content @user_attributes.info.name
      click_link "Facebook"
      expect(page).to have_content @user_attributes.info.name
      expect(page).to have_button "I need help with tasks"
      expect(page).to have_button "I want to carry out tasks"
    end
  end

  context "when user has been registered before" do
    scenario "user should go straight to his profile page" do
      visit signin_path
      @user = User.first_or_create_from_oauth(@user_attributes)
      @user.user_type = "tasker"
      @user.save
      expect(page).to have_no_link "Edit Profile"
      click_link "Facebook"
      expect(page).to have_link @user_attributes.info.name
      click_on @user_attributes.info.name
      expect(page).to have_link "Sign Out"
      expect(page).to have_link "Edit Profile"
    end
  end
end
