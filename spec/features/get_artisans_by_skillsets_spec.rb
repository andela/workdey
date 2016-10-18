require "rails_helper"

RSpec.feature "GetArtisansBySkillsets", type: :feature do
  before(:each) do
    @tasker = create(:user, confirmed: true)
    @artisan = create(:user, user_type: "artisan")
    @other_artisan = create(:user,
                           email: Faker::Internet.email,
                           user_type: "artisan")
    @skillset = create(:skillset)
    @artisan.skillsets << @skillset
  end

  feature "search artisans by skillsets" do
    before do
      page.driver.browser.manage.window.maximize
    end
    before(:each) do
      log_in_with @tasker.email, @tasker.password
    end

    scenario "tasker searches with skillsets that have artisans" do
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
      expect(page).to have_no_content @other_artisan.fullname
      expect(page).to have_content @artisan.fullname
    end

    scenario "search for with skillsets that have no artisans" do
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

      expect(page).to have_no_content @other_artisan.fullname
      expect(page).to have_no_content @artisan.fullname
      expect(page).to have_content "We could not find any result matching your"\
        " query"
    end
  end
end
