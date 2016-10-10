require "rails_helper"

RSpec.feature "List applicants", type: :feature do
  before do
    page.driver.browser.manage.window.maximize
  end
  let(:admin) { create(:user, user_type: "admin", confirmed: true) }
  scenario "when user is an admin" do
    log_in_with(admin.email, admin.password)
    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "View Applications"
  end

  scenario "when there are no applicants to review" do
    log_in_with(admin.email, admin.password)
    click_link "View Applications"
    expect(page).to have_content "There are no applicants to review"
  end

  scenario "when user is not an admin" do
    user = create(:user)
    log_in_with(user.email, user.password)
    expect(current_path).to eq "/dashboard"
    expect(page).to_not have_content "View Applications"
  end

  scenario "when user clicks View Applications" do
    create(:user, user_type: "taskee")
    log_in_with(admin.email, admin.password)
    click_link "View Applications"
    expect(page).to have_content "View"
    expect(page.current_path).to eq "/admin/applicants"
  end
end
