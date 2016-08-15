require "rails_helper"

RSpec.describe "Broadcast tasks", type: :feature do
  let(:message) { "Available Taskees have been notified" }
  let!(:user) do
    create(:user, user_attr.merge(user_type: "tasker"))
  end
  let!(:skillset) { create(:skillset, user: user) }
  let(:price_range) do
    [
      Faker::Commerce.price(2000..3000).to_s,
      Faker::Commerce.price(3001..5000).to_s
    ]
  end
  let(:task) do
    create(
      :task,
      skillset_id: skillset.id,
      tasker_id: user.id,
      price_range: price_range
    )
  end

  before do
    log_in_with user.email, user.password
    visit "dashboard/tasks/#{task.id}"
  end

  context "when a user broadcasts a task" do
    scenario "Tasker broadcasts task" do
      click_on "Broadcast Task"
      expect(page).to have_content message
    end
  end

  context "when a tasker closes bidding" do
    let(:task) do
      create(
        :task,
        skillset_id: skillset.id,
        tasker_id: user.id,
        price_range: price_range,
        broadcasted: true
      )
    end
    let(:message) { "Bids successfully closed" }

    scenario "Tasker closes bidding" do
      click_on "Close Bid"
      expect(page).to have_content message
    end
  end
end
