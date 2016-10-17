require "rails_helper"

RSpec.feature "Create a reference", type: :feature do
  before(:each) do
    @user = create(:user, user_attr.merge(user_type: "artisan"))
    @skill = create(:skillset)
    @user.skillsets << @skill
  end

  before(:all) do
    Capybara.default_driver = :selenium
    Capybara.ignore_hidden_elements = false
  end

  before { log_in_with(@user.email, @user.password) }
  context "when a artisan has no skill set" do
    scenario "clicks 'My Refereces' link" do
      visit dashboard_references_path

      expect(page).to have_content "My References"
      expect(page).to have_content "You have no existing references"
      expect(page).not_to have_content "Input details of your reference"
    end
  end

  feature "reference" do
    scenario "when artisan fills reference form" do
      visit new_dashboard_reference_path
      fill_in "reference_firstname", with: Faker::Name.first_name
      fill_in "reference_lastname", with: Faker::Name.last_name
      fill_in "reference_email", with: "marquis.carroll@wilder.io"
      fill_in "reference_relationship", with: "Professional"
      find("label", text: @skill.name.to_s).click
      click_button "Send Email"
      expect(page).
        to have_content("An email will be sent to marquis.carroll@wilder.io")
      expect(current_path).to eq(new_dashboard_reference_path)
    end

    scenario "when artisan does not fill reference form" do
      visit new_dashboard_reference_path
      click_button "Send Email"
      expect(page).to have_css("input.invalid")
      expect(page).to have_content("Please choose at least one skill")
    end
  end
end
