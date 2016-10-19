require "rails_helper"

RSpec.feature "Create Task for bidding", type: :feature do
  let(:user) { create(:user, confirmed: true) }

  before(:each) do
    log_in_with(user.email, user.password)
  end

  scenario "user logs in" do
    expect(page).to have_selector("a", text: "email")
  end

  scenario "user clicks message button to contact workdey staff" do
    click_link "email"

    expect(page).to have_selector("h2", text: "Contact Form")
    expect(page).to have_css("form.contact_form")
  end

  scenario "user can fill the contact form" do
    fill_contact_form

    expect(page).to have_content("Message sent successfully")
    expect(page).to have_selector("a", text: "email")
  end
end
