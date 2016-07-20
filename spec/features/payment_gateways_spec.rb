require "rails_helper"

RSpec.feature "PaymentGateways", type: :feature do
  let!(:tasker) { create(:user, confirmed: true) }

  before do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "tasker creates a task that is unpaid for" do
    log_in_with(tasker.email, tasker.password)
    fill_in "searcher", with: "Cleaning"
    click_button "Search"
    click_on("view-taskee" + User.second.id.to_s)
    click_on "ASSIGN TASK"
    fill_in "task_management_amount", with: "5000"
    fill_in "task_management_task_desc", with: Faker::Lorem.sentence
    click_on "create-task"
    expect(page).to have_content("You will have to pay before your taskee will"\
      " be notified")
    expect(page).to have_button("Pay with Card")
    expect(TaskManagement.first.paid?).to be_falsy
  end
end
