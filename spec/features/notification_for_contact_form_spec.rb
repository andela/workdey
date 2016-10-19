require "rails_helper"

RSpec.feature "Create Task for bidding", type: :feature do
  let(:user) { create(:user, confirmed: true) }
  let(:admin) { create(:user, user_type: "admin", confirmed: true) }

  before do
    log_in_with(user.email, user.password)
    fill_contact_form
    visit logout_path
  end

  context "when user is artisan or tasker" do
    before do
      log_in_with(admin.email, admin.password)
      respond_to_enquiry
      visit logout_path
      log_in_with(user.email, user.password)
    end

    scenario "user gets notification when response has been made" do

    end

    scenario "user sees response to question asked" do
      visit notifications_path
      page.all(".btn")[0].click

      expect(page).to have_content "Response to your enquiry"
    end
  end

  context "when user is admin" do
    before do
      log_in_with(admin.email, admin.password)
    end

    scenario "admin gets notification when an enquiry has been asked" do

    end

    scenario "admin clicks on notification" do
      visit notifications_path
      page.all(".btn")[0].click

      expect(page).to have_content "Respond to enquiry"
    end

    scenario "admin responds to question" do
      let(:question) { create(:enquiry, user_id: user.id) }

      visit "/admin/enquiry/#{question.id}"
      respond_to_enquiry

      expect(page).to have_content "Response sent successfully"
    end
  end
end
