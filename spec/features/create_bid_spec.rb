require "rails_helper"

RSpec.feature "Taskee Bid", type: :feature do
  let(:taskee) do
    create(:user, user_type: "taskee", confirmed: true, has_taken_quiz: true)
  end
  let(:skillset) { create(:skillset, user_id: taskee.id) }
  let(:tasker) { create(:user) }
  let(:task) do
    create(
      :task,
      tasker_id: tasker.id,
      broadcasted: true,
      skillset_id: skillset.id
    )
  end

  before(:each) do
    log_in_with(taskee.email, taskee.password)
  end

  scenario "taskee can make a bid" do
    taskee_make_bid
    expect(page).to have_content "You have successfully made a bid"
  end

  scenario "taskee can revise their bid" do
    price_change = Faker::Commerce.price(3000..4000)

    taskee_make_bid
    click_link "Revise"
    within "form" do
      fill_in "bid[price]", with: price_change
      find('input[type=submit]').click
    end

    expect(page).to have_content "Bid successfully updated"
  end

  scenario "taskee can delete their bid" do
    taskee_make_bid
    click_link "Destroy"

    expect(page).to have_content "Bid successfully deleted"
  end
end
