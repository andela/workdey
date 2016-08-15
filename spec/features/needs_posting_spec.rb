require "rails_helper"

RSpec.describe "Task Creation and Assignment", js: true, type: :feature do
  let(:message) { "Your need has been created" }

  before(:each) do
    @user = create(:user, user_attr.merge(user_type: "tasker"))
    @skillset = create(:skillset)
    @user.skillsets << @skillset
  end

  describe "creating task with valid data" do
    scenario "when creating a Task without location" do
      new_task_helper(4000)
      click_button "Create Task"
      expect(page).to have_content "Your task has been created"
    end
  end

  describe "creating a task with invalid data" do
    scenario "when creating a task with less than 2000" do
      new_task_helper(1599)
      click_button "Create Task"
      expect(page).to have_content "Prices must be greater than $2000"
    end
  end
end
