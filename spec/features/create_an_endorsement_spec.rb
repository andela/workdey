require "rails_helper"

RSpec.feature "Submit an endorsement", type: :feature do
  let(:user) { create(:user, user_attr.merge(user_type: "artisan")) }
  let!(:reference) { create(:reference, artisan_id: user.id) }
  let(:url) do
    "http://#{Capybara.current_session.server.host}:" \
    "#{Capybara.current_session.server.port}" \
    "#{new_dashboard_endorsement_path}?t=#{reference.confirmation_token}"
  end
  let(:skill) { JSON.parse(reference.skillsets.values.first).first }

  before(:all) do
    Capybara.default_driver = :selenium
    Capybara.ignore_hidden_elements = false
  end

  context "when all fields are filled" do
    scenario "visits confirmation path" do
      visit url
      find("label", text: skill).click
      fill_in "recommendation", with: "#{user.firstname} is very hard working."
      click_button "Send"
      expect(page).to have_content("Your recommendation has been sent.")
    end
  end

  context "when all fields are not filled" do
    scenario "clicks submit button" do
      visit url
      click_button "Send"
      expect(page).to have_css("input.invalid")
      expect(page).to have_content("Please choose at least one skill")
    end
  end
end
