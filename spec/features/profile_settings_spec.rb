require "rails_helper"

RSpec.feature "ProfileSettings", type: :feature do
  before do
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "login with valid email and password" do
    log_in_with "ruth.chukwumam@andela.com", "1234567890"
    expect(page).to have_content("Workdey Taskee Verification Quiz")
  end

  scenario "view profile" do
    log_in_with "ruth.chukwumam@andela.com", "1234567890"
    visit profile_path
    expect(page).to have_content("User Profile Settings")
  end

  scenario "update profile" do
    log_in_with "ruth.chukwumam@andela.com", "1234567890"
    visit profile_path
    fill_in "phone", with: "1234567890"
    fill_in "street_address", with: "23, Olaide Street"
    select "Female", from: "gender"
    select "2", from: "date_day"
    select "January", from: "date_month"
    select "1980", from: "date_year"
    select "Yaba", from: "city"
    select "Lagos", from: "state"
    click_button "UPDATE PROFILE"
    expect(page).to have_content("Your profile has been successfully updated!")
  end

  def log_in_with(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
  end
end
