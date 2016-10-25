require "rails_helper"

RSpec.feature "PaymentGateways", type: :feature do
  let(:tasker) { create(:user, confirmed: true) }
  let(:artisan) { create(:user, user_type: "artisan") }

  scenario "tasker creates a task that is unpaid for" do
    log_in_with(tasker.email, tasker.password)
    create(:task_management, tasker: tasker, artisan: artisan)
    visit my_tasks_path
    expect(page).to have_content("Pay for this task")
    click_on "Pay for this task"
    expect(page).to have_content("You will have to pay before your artisan"\
    " will be notified")
    expect(page).to have_button("Pay with Card")
    expect(TaskManagement.first.paid?).to be_falsy
  end
end
