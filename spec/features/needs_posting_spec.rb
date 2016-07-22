# frozen_string_literal: true
require "rails_helper"

RSpec.describe "Task Creation and Assignment", js: true, type: :feature do
  let(:taskee) { create(:user, user_attr.merge(user_type: "taskee")) }
  let(:taskee2) { create(:user, user_attr.merge(user_type: "taskee")) }
  let(:tasker) { create(:user, user_attr.merge(user_type: "tasker")) }
  let(:skillset) { create(:skillset, user: taskee) }
  let(:skillset2) { create(:skillset, name: skillset.name, user: taskee2) }

  describe "creating task with valid data" do
    scenario "when creating a Task without location" do
      new_task_helper(4000)
      click_button "Post Need"
      expect(page).to have_content "Your need has been created"
    end
  end

  describe "creating a task with invalid data" do
    scenario "when creating a task with less than 2000" do
      new_task_helper(1599)
      click_button "Post Need"
      expect(page).to have_content "Price must be greater than or equal to 2000"
    end
  end
end
