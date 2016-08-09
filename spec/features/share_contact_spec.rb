require "rails_helper"

RSpec.describe "Share contact", js: true do
  let(:taskee) { create(:user, user_type: "taskee", confirmed: true) }
  let(:tasker) { create(:user, confirmed: true) }
  let!(:task) do
    create(
      :task_management,
      taskee_id: taskee.id,
      tasker_id: tasker.id,
      paid: true,
      status: "active"
    )
  end

  before(:each) do
    log_in_with(taskee.email, taskee.password)
  end

  describe "taskee" do
    scenario "When taskee shares contact with tasker" do
      share_contact

      expect(page).to have_content("You have shared "\
      "your contact with the tasker")
      expect(task.reload.shared).to be eq true
    end

    scenario "When taskee doesn't share contact with tasker" do
      visit my_tasks_path
      click_on "Share Contact"
      click_on "No, don't share"
      click_on "OK"

      expect(page).to have_content("You can share your contact later")
      expect(task.reload.shared).to be eq false
    end
  end

  describe "tasker" do
    scenario "when tasker views the taskee details " do
      share_contact
      Capybara.reset_sessions!
      log_in_with(tasker.email, tasker.password)
      visit notifications_path
      click_on "view information"

      expect(page).to have_content(taskee.firstname)
      expect(page).to have_content(taskee.email)
    end
  end

  def share_contact
    visit my_tasks_path
    click_on "Share Contact"
    click_on "Yes, share it"
    click_on "OK"
  end
end
