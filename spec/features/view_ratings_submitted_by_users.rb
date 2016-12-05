require "rails_helper"

RSpec.feature "ViewRatings", type: :feature do
  scenario "User views submitted ratings" do
    @tasker = create(:user)
    @artisan = create(
      :user,
      user_type: "artisan",
      confirmed: true,
      has_taken_questionnaire: true,
      status: 5
    )
    @service = create(:service, tasker: @tasker, artisan: @artisan)
    create :service_rating, service: @service

    visit signin_path
    log_in_with(@artisan.email, @artisan.password)
    stub_current_user(@artisan)
    click_link "View Ratings"

    expect(page).to have_css("div#average-service-rating")

    find_all("tr td a.btn")[0].click

    expect(page).to have_content(@artisan.firstname)
  end
end
