require "rails_helper"

RSpec.feature "Review applicant", type: :feature do
  before do
    page.driver.browser.manage.window.maximize
    log_in_with(admin.email, admin.password)
  end
  let(:admin) { create(:user, user_type: "admin", confirmed: true) }
  let!(:applicant) { create(:user, user_type: "taskee") }

  scenario "when admin clicks view button" do
    visit "/admin/applicants"
    click_link "View"
    expect(page.current_path).to eql "/admin/applicants/#{applicant.id}/edit"
    expect(page).to have_content "Accept"
  end

  scenario "when admin reviews an applicant" do
    visit "/admin/applicants/#{applicant.id}/edit"
    choose "Accept"
    fill_in "Reasons", with: "Good"
    click_button "UPDATE"
    expect(page.current_path).to eq "/admin/applicants"
  end

  scenario "when admin does not fill reasons" do
    visit "/admin/applicants/#{applicant.id}/edit"
    choose "Accept"
    click_button "UPDATE"
    expect(page).to have_content "Please fill out this field"
  end
end
