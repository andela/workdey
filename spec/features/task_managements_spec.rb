require "rails_helper"

RSpec.feature "TaskLogs", type: :feature do
  before do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
    create(:task_management, task_desc: "Iron these clothes for me")
  end

  scenario "should see a list of tasks created if you are a tasker" do
    log_in_with "temitope.amodu@andela.com", "1234567890"
    expect(page).to have_content("Taskee Name")
    expect(page).to have_content("Serial No")
  end

  scenario "should see a list of tasks given if you are a taskee" do
    log_in_with "olaide.ojewale@andela.com", "1234567890"
    expect(page).to have_content("Tasker")
  end

  def log_in_with(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
    visit my_tasks_path
  end
end
