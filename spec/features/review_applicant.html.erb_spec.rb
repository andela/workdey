require "rails_helper"

RSpec.feature "Review applicant", type: :feature do
  before do
    page.driver.browser.manage.window.maximize
    log_in_with(admin.email, admin.password)
  end
  let(:admin) { create(:user, user_type: "admin", confirmed: true) }
  let!(:applicant) { create(:user, user_type: "artisan") }

  scenario "when admin clicks view button" do
    visit "/admin/applicants"
    click_link "View"
    expect(page).to have_content "Accept"
    expect(page.current_path).to eql "/admin/applicants/#{applicant.id}/edit"
  end

  scenario "when admin accepts an applicant" do
    visit "/admin/applicants/#{applicant.id}/edit"
    find("label[for=user_status_1]").click
    fill_in "Reasons", with: "Good"
    click_button "Update"
    expect(page.current_path).to eq "/admin/applicants"
  end

  scenario "when admin rejects an applicant" do
    visit "/admin/applicants/#{applicant.id}/edit"
    find("label[for=user_status_2]").click
    fill_in "Reasons", with: "Bad"
    click_button "Update"
    expect(page.current_path).to eq "/admin/applicants"
  end
end
