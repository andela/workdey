require "rails_helper"

RSpec.feature "ListTaskeesAndSkillsets", type: :feature do
  before(:each) do
    @tasker = create(:user, confirmed: true)
  end

  feature "taskee and skillsets view" do
    scenario "when there are available taskees" do
      create(:user, confirmed: true, user_type: "taskee")
      taskee = User.last
      log_in_with @tasker.email, @tasker.password
      visit taskees_path

      expect(page).to have_css("table")

      within "table" do
        expect(page).to have_text "Taskee"
        expect(page).to have_content "Skillsets"
        expect(page).to have_content "Location"
        expect(page).to have_link "View"
        expect(page).to have_link taskee.fullname
        page.driver.browser.manage.window.maximize
        click_on taskee.fullname
      end
      expect(page).to have_content taskee.firstname + "'s Profile"
    end

    scenario "when there are no available taskees" do
      log_in_with @tasker.email, @tasker.password
      visit taskees_path

      expect(page).to have_no_css "table"
      expect(page).to have_content "There are currently no taskees here"
    end
  end
end
