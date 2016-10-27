require "rails_helper"

RSpec.feature "Floating enquiry form", type: :feature do
  let(:user) { create(:user, confirmed: true) }
  let(:admin) { create(:user, user_type: "admin") }

  before(:each) do
    log_in_with(user.email, user.password)
  end

  scenario "user clicks floating message icon" do
    click_button "email"

    expect(page).to have_selector("h3", text: "Enquiry")
  end

  scenario "user fills the contact form" do
    fill_contact_form
    expect(current_path).to eq "/dashboard"
  end
end
