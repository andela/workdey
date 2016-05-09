require "rails_helper"

RSpec.feature "TaskLogs", type: :feature do
  before do
    Capybara.default_driver = :selenium
    @task1 = create(:task_management, task_desc: "Iron these clothes for me")
    @task2 = create(:task_management, task_desc: "Wash my dishes",
                                      tasker_id: 2, taskee_id: 3)
    @user = create(:user)
    @user2 = create(:user, email: "olufunmi.abosede@andela.com",
                           firstname: "Olufunmi", lastname: "Abosede",
                           user_type: "taskee")
  end
  context "user is a tasker" do
    before do
      log_in_with @user.email, @user.password
    end
    scenario "should see a list of tasks created if you are a tasker" do
      expect(page).to have_content("Taskee Name")
      expect(page).to have_content("Serial No")
    end

    scenario "tasker should see only his tasks" do
      expect(page).to have_content("Iron these clothes for me")
      expect(page).to_not have_content("Wash my dishes")
    end
  end
  context "user is a taskee" do
    before do
      log_in_with @user2.email, @user2.password
    end
    scenario "should see a list of tasks given if you are a taskee" do
      expect(page).to have_content("Tasker")
    end
    scenario "taskee should see only tasks assigned" do
      expect(page).to have_content("Iron these clothes for me")
      expect(page).to_not have_content("Wash my dishes")
    end
  end

  def log_in_with(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
    visit my_tasks_path
  end
end
