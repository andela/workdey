require "rails_helper"

RSpec.feature "SearchByTasks", type: :feature do
  scenario "search by tasks" do
    taskee = create(:user, user_attr.merge(user_type: "taskee"))
    skillset = create(:skillset, user: taskee)
    visit "/"
    fill_in "searcher", with: skillset.name
    click_button "Search"
    expect(page).to have_selector("p", text: taskee.firstname)
  end
end
