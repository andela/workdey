require "rails_helper"

RSpec.feature "Create a reference", type: :feature do
  let(:user) { create(:user, user_attr.merge(user_type: "taskee")) }
  let!(:skill) { create(:skillset, user: user) }

  before(:all) { Capybara.default_driver = :selenium }
  before { log_in_with(user.email, user.password) }

  scenario "clicks 'My Refereces' click" do
    click_link "My References"
    expect(page).to have_content("My References")
    expect(page).to have_css("a#new-reference-btn")
  end

  context "skill set" do
    before do
      click_link "My References"
      click_link "new-reference-btn"
    end

    context "when taskee has skill set" do
      scenario "clicks plus button" do
        expect(page).to have_content(" Input details of your reference")
      end
    end
  end
end
