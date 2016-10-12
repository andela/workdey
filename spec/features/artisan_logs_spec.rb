require "rails_helper"

RSpec.feature "Artisan Log" do
  before :each do
    artisan_stub
  end

  context "Task logs page" do
    before do
      log_in_with @artisan.email, @artisan.password
    end

    it { expect(page).to have_content("Welcome #{@artisan.firstname}") }

    scenario "see tasker names for the task assigned" do
      visit my_tasks_path

      expect(page).to have_content("Tasker")
    end

    scenario "artisan sees assigned tasks" do
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
