# frozen_string_literal: true
require "rails_helper"

RSpec.feature do
  scenario "guest can open Contact Us page" do
    visit root_path
    click_link "Contact us"
    expect(page).to have_selector("body.pages-contact")
  end

  scenario "guest can submit contact information" do
    visit contact_path
    fill_in "name", with: "Jane Doe"
    fill_in "email", with: "jane.doe@workdey.com"
    fill_in "subject", with: "Foo Bar"
    fill_in "message", with: "Lorem ipsum sit ammet"
    click_button "SEND"
    expect(page).to have_content("Thanks for contacting us! We appreciate it.")
  end
end
