require "rails_helper"

RSpec.describe "Broadcast tasks", type: :feature do
  let(:message) { "Available Taskees have been notified" }

  before(:each) do
    @user = create(:user, user_attr.merge(user_type: "tasker"))
    @skillset = create(:skillset)
    @user.skillsets << @skillset
  end

  let(:skillsets) { create_list(:skillset, 4) }
  let!(:skillset) do
    create(:taskee_skillset, taskee: user, skillset: skillsets.first)
  end
  let(:price_range) do
    [
      Faker::Commerce.price(2000..3000).to_s,
      Faker::Commerce.price(3001..5000).to_s
    ]
  end

  let(:task) do
    create(
      :task,
      skillset_id: @skillset.id,
      tasker_id: @user.id
    )
  end

  before do
    log_in_with @user.email, @user.password
    visit "/tasks/#{task.id}"
  end

  context "when a user broadcasts a task" do
    scenario "Tasker broadcasts task" do
      click_on "Broadcast Task"
      within ".modal-content" do
        fill_in "min_price", with: "2000"
        fill_in "max_price", with: "3000"
      end
      find_button("Broadcast Task").click

      expect(page).to have_content message
    end
  end

  context "when a tasker closes bidding" do
    let(:task) do
      create(
        :task,
        skillset_id: @skillset.id,
        tasker_id: @user.id,
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