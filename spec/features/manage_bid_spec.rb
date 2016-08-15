require "rails_helper"

RSpec.feature "Tasker bids", type: :feature do
  let(:taskee) do
    create(:user, user_type: "taskee", confirmed: true, has_taken_quiz: true)
  end
  let(:skillset) { create(:skillset, user_id: taskee.id) }
  let(:tasker) { create(:user) }
  let(:task) do
    create(
      :task,
      tasker_id: tasker.id,
      broadcasted: true,
      skillset_id: skillset.id
    )
  end

  before(:each) do
    create(:bid, user_id: taskee.id, task_id: task.id)
    log_in_with(tasker.email, tasker.password)
  end

  scenario "tasker can choose taskee bidder" do
    tasker_choose_bidder

    expect(page).to have_content "Bid successfully assigned"
  end

  scenario "tasker can accept a task (mark a task as finished)" do
    tasker_choose_bidder

    click_link "Accept"

    expect(page).to have_content "Task accepted"
  end

  scenario "tasker can decline a task" do
    tasker_choose_bidder

    click_link "Decline"

    expect(page).to have_content "Task declined!"
  end
end
