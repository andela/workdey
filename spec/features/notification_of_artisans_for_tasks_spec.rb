require "rails_helper"

RSpec.describe "Notification of artisans for new tasks", type: :feature do
  let(:artisan) { create(:user, user_attr.merge(user_type: "artisan")) }
  let(:tasker) { create(:user, user_attr.merge(user_type: "tasker")) }
  let(:skillset) { create(:skillset) }
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
      tasker_id: tasker.id,
      price_range: price_range
    )
  end

  before(:each) do
    create(
      :notification,
      notifiable_id: task.id,
      receiver_id: artisan.id,
      sender_id: tasker.id,
      notifiable_type: "Task"
    )
    log_in_with artisan.email, artisan.password
    visit notifications_path
    page.all(".btn")[0].click
  end

  scenario "artisan rejects a task" do
    click_on "Reject"
    expect(page).to have_content "Task rejected"
  end

  scenario "artisan accepts a task" do
    click_on "Accept"
    expect(page).to have_content "Task accepted"
  end
end
