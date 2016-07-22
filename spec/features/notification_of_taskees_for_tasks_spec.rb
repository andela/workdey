require "rails_helper"

RSpec.describe "Notification of taskees for new tasks", type: :feature do
  let(:taskee) { create(:user, user_attr.merge(user_type: "taskee")) }
  let(:tasker) { create(:user, user_attr.merge(user_type: "tasker")) }
  let(:task) { create(:task, task_attr) }

  before(:each) do
    create(
      :notification,
      notifiable_id: task.id,
      receiver_id: taskee.id,
      sender_id: tasker.id,
      notifiable_type: "Task"
    )
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
