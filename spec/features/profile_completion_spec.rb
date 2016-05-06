require "rails_helper"

RSpec.describe "Profile completion meter" do
  before(:all) do
    Capybara.default_driver = :selenium
  end

  before(:each) do
    @user = create(:user, user_type: "taskee", has_taken_quiz: true, confirmed: true, phone: nil)
  end

  scenario "when a Users log into their account" do
    log_in_with(@user.email, @user.password)
    expect(page).to have_content "Welcome #{@user.firstname}"

    within("div.profile-meter") do
      expect(page).to have_content "64%"
    end
  end

  scenario "users after updating their account, their profile completeness "\
    " should increase" do
    log_in_with(@user.email, @user.password)

    within("div.profile-meter") do
      expect(page).to have_content "64%"
    end

    click_link "Complete Your Profile"
    fill_in "phone", with: "1234567890"
    fill_in "street_address", with: "69, Olalekan Street"
    click_button "UPDATE PROFILE"
    click_on "Home"

    within("div.profile-meter") do
      expect(page).to have_content "82%"
    end
  end

  def log_in_with(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
  end
end
