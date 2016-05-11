require "rails_helper"

RSpec.feature "Taskee skillset" do
  before(:all) do
    Capybara.default_driver = :selenium
  end

  before(:each) do
    user_attr = {
      user_type: "taskee",
      has_taken_quiz: true,
      confirmed: true,
      phone: nil
    }
    @user = create(:user_with_tasks, user_attr)
    log_in_with(@user.email, @user.password)
  end

  scenario "taskee can see link to skillset page" do
    within("div.sidebar-dash") { expect(page).to have_content("My Skillset") }
  end

  scenario "taskee can see a list of own skillset" do
    click_link "My Skillset"
    expect(page).to have_selector("li.collection-item", "Trainer")
  end

  scenario "taskee can add a new task to skillset" do
    visit "/skillsets"
    fill_in "task_name", with: "Cleaning"
    click_button "Create Task"
    expect(page).to have_selector("li.collection-item", "Cleaning")
  end

  scenario "taskee can remove task from skillset" do
    visit "/skillsets"
    within('div#task_1') { click_link "delete" }
    expect(page).not_to have_selector("#task_1")
  end

  scenario "taskee gets a notification on duplicate entry attempt" do
    visit "/skillsets"
    fill_in "task_name", with: "Trainer"
    click_button "Create Task"
    expect(page).to have_content("Trainer already exists.")
  end
end
