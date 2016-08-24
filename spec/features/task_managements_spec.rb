require "rails_helper"

RSpec.feature "TaskLogs", type: :feature do
  before do
    task1_desc = "Lorem ipsum dolor sit amet"
    task2_desc = "consectetur adipisicing elit"
    @task1 = create(:task_management, description: task1_desc, paid: true)
    @task2 = create(:task_management, description: task2_desc,
                                      tasker_id: 2, taskee_id: 3)
    @user = create(:user, confirmed: true)
    @user2 = create(:user, email: Faker::Internet.email,
                           firstname: Faker::Name.first_name,
                           lastname: Faker::Name.last_name,
                           user_type: "taskee", confirmed: true)
  end

  it { expect(TaskManagement.count).to eql 2 }
  context "user is a tasker" do
    before do
      log_in_with @user.email, @user.password
    end

    scenario "should see a list of tasks created if you are a tasker" do
      expect(page).to have_content("Taskee")
    end

    scenario "tasker should see only his tasks" do
      expect(page).to have_css("table")
      within "table" do
        expect(page).to have_content(@task1.description.description_helper)
        expect(page).to_not have_content(@task2.description)
      end
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
      expect(page).to have_content(@task1.description)
      expect(page).to_not have_content(@task2.description)
    end
  end

  def log_in_with(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
    visit my_tasks_path
  end

  class String
    def description_helper
      self[0, 48] + "..."
    end
  end
end
