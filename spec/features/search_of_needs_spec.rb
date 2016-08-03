require "rails_helper"

RSpec.describe "Searching for needs", type: :feature do
  let(:skillset) { create(:skillset) }
  let(:skillset2) { create(:skillset) }
  let(:tasker) { create(:user, user_attr.merge(user_type: "tasker")) }
  let(:price_range) do
    [
      Faker::Commerce.price(2000..3000).to_s,
      Faker::Commerce.price(3001..5000).to_s
    ]
  end
  let!(:task1) do
    create(
      :task,
      skillset_id: skillset.id,
      tasker_id: tasker.id,
      price_range: price_range
    )
  end
  let!(:task2) do
    create(
      :task,
      skillset_id: skillset.id,
      tasker_id: tasker.id,
      price_range: price_range,
      start_date: Date.yesterday
    )
  end
  let(:taskee) { create(:user, user_attr.merge(user_type: "taskee")) }

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
