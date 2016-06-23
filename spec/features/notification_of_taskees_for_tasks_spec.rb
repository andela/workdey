require "rails_helper"

RSpec.describe "Notification of taskees for new tasks", type: :feature do
  before(:all) do
    # Capybara.default_driver = :selenium
  end

  let(:taskee) { create(:user, user_attr.merge(user_type: "taskee")) }
  let(:tasker) { create(:user, user_attr.merge(user_type: "tasker")) }
  let(:task) { create(:task) }
  let!(:skillset) { create(:skillset, task: task, user: taskee) }

  before(:each) do
    log_in_with tasker.email, tasker.password
    fill_in "searcher", with: task.name
    click_button "Search"
    page.all(".searched-taskee")[0].click
    click_link "ASSIGN TASK"
    fill_in "task_management_amount", with: "4000"
    fill_in "task_management_task_desc", with: Faker::Lorem.sentence
    click_button "Notify Taskee"
    Capybara.reset_sessions!

    log_in_with taskee.email, taskee.password
    visit notifications_path
    page.all(".btn")[0].click
  end

  scenario "taskee rejects a task" do
    click_on "Reject"
    expect(page).to have_content "Task rejected"
  end

  scenario "taskee accepts a task" do
    click_on "Accept"
    expect(page).to have_content "Task accepted"
  end
end
