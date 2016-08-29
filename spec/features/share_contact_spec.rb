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

      expect(page).to have_content("You have shared "\
      "your contact with the tasker")
      expect(task.reload.shared).to be_truthy
    end
  end

  def share_contact(share = true)
    visit my_tasks_path
    click_on "Share Contact"
    sleep 1.5
    share ? click_on("Yes, share it") : click_on("No, don't share")
    click_on "OK"
  end
end
