require "rails_helper"

RSpec.feature "TaskeeLogs" do
  let(:user) { create(:user) }
  let(:user_tasks) { create(:user_with_tasks, email: "hbu@gumba.com") }

  before do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "view profile" do
    log_in_with attributes_for(:user)[:email], attributes_for(:user)[:password]
    visit profile_path
    expect(page).to have_content("User Profile Settings")
  end

  def log_in_with(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
  end
end
