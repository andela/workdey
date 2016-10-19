require "rails_helper"

RSpec.feature "ListArtisansAndSkillsets", type: :feature do
  before(:each) do
    @tasker = create(:user, confirmed: true)
  end

  feature "artisan and skillsets view" do
    scenario "when there are available artisans" do
      create(:user, confirmed: true, user_type: "artisan")
      artisan = User.last
      log_in_with @tasker.email, @tasker.password
      visit artisans_path

      expect(page).to have_css("table")

      within "table" do
        expect(page).to have_text "Artisan"
        expect(page).to have_content "Skillsets"
        expect(page).to have_content "Location"
        expect(page).to have_link "View"
        expect(page).to have_link artisan.fullname
        page.driver.browser.manage.window.maximize
        click_on artisan.fullname
      end
      expect(page).to have_content artisan.firstname + "'s Profile"
    end

    scenario "when there are no available artisans" do
      log_in_with @tasker.email, @tasker.password
      visit artisans_path

      expect(page).to have_no_css "table"
      expect(page).to have_content "There are currently no artisans here"
    end
  end
end
