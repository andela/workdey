require "rails_helper"

RSpec.feature "SearchByTasks", type: :feature do
  before do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "search by tasks" do
    visit "/"
    fill_in "searcher", with: "Cleaning"
    click_button "Search"
    expect(page).to have_selector("p", text: "Chinedu Daniel")
  end
end
