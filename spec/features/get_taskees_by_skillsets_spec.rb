require "rails_helper"

RSpec.feature "GetTaskeesBySkillsets", type: :feature do
  before(:each) do
    @tasker = create(:user, confirmed: true)
    @taskee = create(:user, user_type: "taskee")
    @other_taskee = create(:user,
                           email: Faker::Internet.email,
                           user_type: "taskee")
    @skillset = create(:skillset, user: @taskee)
  end

  feature "search taskees by skillsets" do
    before do
      page.driver.browser.manage.window.maximize
    end
    before(:each) do
      log_in_with @tasker.email, @tasker.password
    end

    scenario "tasker searches with skillsets that have taskees" do
      find("#search").click
      fill_in "my-search-field", with: @skillset.name
      find("#my-search-field").native.send_keys(:return)

      within "nav#nav-wrapper" do
        expect(page).to have_css("i#search")
        expect(page).to have_css("i.material-icons")
      end

      within :xpath, '//*[@id="nav-wrapper"]/div/ul[2]' do
        expect(page).to have_css("i#search")
        expect(page).to have_css("i.material-icons")
      end
      expect(page).to have_no_content @other_taskee.fullname
      expect(page).to have_content @taskee.fullname
    end

    scenario "search for with skillsets that have no taskees" do
      find("#search").click
      fill_in "my-search-field", with: "cleaning"
      find("#my-search-field").native.send_keys(:return)

      within "nav#nav-wrapper" do
        expect(page).to have_css("i#search")
        expect(page).to have_css("i.material-icons")
      end

      within :xpath, '//*[@id="nav-wrapper"]/div/ul[2]' do
        expect(page).to have_css("i#search")
        expect(page).to have_css("i.material-icons")
      end

      expect(page).to have_no_content @other_taskee.fullname
      expect(page).to have_no_content @taskee.fullname
      expect(page).to have_content "We could not find any result matching your"\
        " query"
    end
  end
end
