require "rails_helper"

RSpec.feature "ListTaskeesAndSkillsets", type: :feature do
  before(:each) do
    @tasker = create(:user, confirmed: true)
  end

  feature "taskee and skillsets view" do
    scenario "when there are available taskees" do
      create_list(:user, 4, confirmed: true, user_type: "taskee")
      log_in_with @tasker.email, @tasker.password
      expect(page).to have_link "Taskee Skillsets"
      click_on "Taskee Skillsets"
      expect(page).to have_css("table")
      within "table" do
        expect(page).to have_text "Taskee"
        expect(page).to have_content "Skillsets"
        expect(page).to have_content "Location"
        expect(page).to have_link "View"
      end
    end

    scenario "when there are no available taskees" do
      log_in_with @tasker.email, @tasker.password
      click_on "Taskee Skillsets"
      expect(page).to have_no_css "table"
      expect(page).to have_content "There are currently no taskees here"
    end
  end
end
