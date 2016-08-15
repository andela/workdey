require "rails_helper"

RSpec.feature "Create a reference", type: :feature do
  before(:each) do
    @user = create(:user, user_attr.merge(user_type: "taskee"))
    @skill = create(:skillset)
    @user.skillsets << @skill
  end

  before(:all) do
    Capybara.default_driver = :selenium
    Capybara.ignore_hidden_elements = false
  end

  before { log_in_with(@user.email, @user.password) }

  scenario "clicks 'My Refereces' click" do
    click_link "My References"
    expect(page).to have_content("My References")
    expect(page).to have_css("a#new-reference-btn")
  end

  context "when taskee has a skill set" do
    scenario "clicks plus button" do
      click_link "My References"
      click_link "new-reference-btn"
      expect(page).to have_content(" Input details of your reference")
    end

    context "when all fields are filled" do
      scenario "fills reference form" do
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
    end

    context "when all fields are not filled" do
      scenario "clicks submit" do
        visit new_dashboard_reference_path
        click_button "Send Email"
        expect(page).to have_css("input.invalid")
        expect(page).to have_content("Please choose at least one skill")
      end
    end
  end
end
