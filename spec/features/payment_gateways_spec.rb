# frozen_string_literal: true
require "rails_helper"

RSpec.feature "PaymentGateways", type: :feature do
  let(:tasker) { create(:user, confirmed: true) }
  let(:taskee) { create(:user, user_type: "taskee") }

  scenario "tasker creates a task that is unpaid for" do
    log_in_with(tasker.email, tasker.password)
    create(:task_management, tasker: tasker, taskee: taskee)
    visit my_tasks_path
    expect(page).to have_content("Pay for this task")
    click_on "Pay for this task"
    expect(page).to have_content("You will have to pay before your taskee will"\
      " be notified")
    expect(page).to have_button("Pay with Card")
    expect(TaskManagement.first.paid?).to be_falsy
  end
end
