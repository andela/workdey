require "rails_helper"

RSpec.feature "Taskee Log" do
  before :each do
    taskee_stub
  end

  context "Task logs page" do
    before do
      log_in_with @taskee.email, @taskee.password
    end

    it { expect(page).to have_content("Welcome #{@taskee.firstname}") }

    scenario "see tasker names for the task assigned" do
      visit my_tasks_path

      expect(page).to have_content("Tasker")
    end

    scenario "taskee sees assigned tasks" do
      visit my_tasks_path

      within "table tbody" do
        expect(page).to have_content("rejected")
        expect(page).to have_content("active")
        expect(page).to have_content("inactive")
        expect(page).to have_content("done")

        expect(page.find_all("tr").size).to eql @statuses.size
      end
    end
  end
end
