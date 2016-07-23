# frozen_string_literal: true
require "rails_helper"

RSpec.feature "Taskee skillset" do
  before(:each) do
    user_attr = {
      user_type: "taskee",
      has_taken_quiz: true,
      confirmed: true,
      phone: nil
    }
    @user = create(:user_with_tasks, user_attr)
    @skillset = create(:skillset, user: @user)
    log_in_with(@user.email, @user.password)
  end

  scenario "taskee can see link to skillset page" do
    within("div.sidebar-dash") { expect(page).to have_content("My Skillset") }
  end

  scenario "taskee can see a list of own skillset" do
    click_link "My Skillset"
    expect(page).to have_selector("li.collection-item", text: @skillset.name)
  end

  scenario "taskee can add a new task to skillset", js: true do
    visit "/skillsets"
    fill_in "skillset_name", with: "Cleaning"
    click_button "Create Skillset"
    expect(page).to have_selector("li.collection-item", text: "Cleaning")
  end

  scenario "taskee can remove task from skillset", js: true do
    visit "/skillsets"
    within("div#skillset_1") { click_link "delete" }
    expect(page).not_to have_selector("#task_1")
  end

  scenario "taskee gets a notification on duplicate entry attempt", js: true do
    visit "/skillsets"
    fill_in "skillset_name", with: @skillset.name
    click_button "Create Skillset"
    expect(page).to have_content("#{@skillset.name} already exists.")
  end
end
