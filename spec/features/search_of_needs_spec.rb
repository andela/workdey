require "rails_helper"

RSpec.describe "Searching for needs", type: :feature do
  let(:skillset) {create(:skillset)}
  let(:skillset2) {create(:skillset)}
  let(:tasker) {create(:user, user_attr.merge(user_type: "tasker"))}
  let!(:task1) do
    create(:task, task_attr.merge(skillset_id: skillset.id, tasker_id: tasker.id))
  end
  let!(:task2) do
    create(:task,
      task_attr.merge(
        name: Faker::Lorem.word,
        skillset_id: skillset.id,
        start_date: Date.yesterday
      )
    )
  end
  let(:taskee) {create(:user, user_attr.merge(user_type: "taskee"))}
  scenario "when user search for need that has a task" do
    search_helper(taskee, skillset)

    within("ul.collection") do
      expect(page).not_to have_content task2.name
      expect(page).to have_content task1.name.capitalize
    end
  end

  scenario "when user search for need that has no task" do
    search_helper(taskee, skillset2)
    
    expect(page).to have_content "No search result found!"
  end

end
