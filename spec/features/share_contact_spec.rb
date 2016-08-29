require "rails_helper"

RSpec.describe "Share contact", js: true do
  before do
    page.driver.browser.manage.window.maximize
  end
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
    scenario "When taskee shares contact with tasker", js: true do
      share_contact

      expect(page).to have_content "Success!"
      expect(task.reload.shared).to be_truthy
    end

    scenario "When taskee doesn't share contact with tasker" do
      share_contact(false)

      expect(page).to have_content("You can share your contact later")
      expect(task.shared).to be_falsy
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

  def share_contact(share = true)
    visit my_tasks_path
    click_on "Share Contact"
    sleep 1.5
    share ? click_on("Yes, share it") : click_on("No, don't share")
  end
end
