require "rails_helper"

RSpec.feature "SearchByTasks", type: :feature do
  let(:email) { "olaide.ojewale@andela.com" }
  let(:password) { "1234567890" }

  before do
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "search by tasks" do
    visit "/"
    fill_in "searcher", with: "Cleaning"
    click_button "Search"
    expect(page).to have_selector("p", text: "Chinedu Daniel")
  end

  scenario "redirect user to login when s/he searches for taskees by tasks" do
    visit "/"
    fill_in "searcher", with: "Cleaning"
    click_button "Search"
    page.all(".searched-taskee")[0].click

    expect(page).to have_content("Login to continue")

    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in "

    expect(page).to have_content("User Profile")
  end
end
