require "rails_helper"

RSpec.describe "Share contact" do
  let(:taskee) { create(:user, user_type: "taskee") }
  let(:tasker) { create(:user) }
  let!(:task) do
    create(
      :task_management,
      taskee_id: taskee.id,
      tasker_id: tasker.id,
      paid_for: true
    )
  end
  before(:each) do
    log_in_with(taskee.email, taskee.password)
  end

  scenario "When taskee shares contact with tasker" do
    visit my_tasks_path
    click_on "Yes, share it"
    click_on "OK"

    expect(task.reload.shared).to be eq true
  end

  scenario "When taskee doesn't share contact with tasker" do
    visit my_tasks_path
    click_on "No, don't share"
    click_on "OK"

    expect(task.reload.shared).to be eq false
  end
end
