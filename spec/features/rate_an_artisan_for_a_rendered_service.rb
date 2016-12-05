require "rails_helper"

RSpec.feature "RateArtisan", type: :feature do
  before do
    page.driver.browser.manage.window.maximize
  end

  scenario "Tasker rates an artisan for a rendered service" do
    @tasker = create(:user)
    @artisan = create(:user, user_type: "artisan")
    @service = create(:service, tasker: @tasker, artisan: @artisan)

    visit signin_path
    log_in_with(@tasker.email, @tasker.password)
    stub_current_user(@tasker)
    click_link "Rate Artisan"
    page.execute_script("$('#service_rating_rating').val(3)")
    fill_in "service_rating_private_feedback", with: Faker::Lorem.paragraph
    fill_in "service_rating_public_feedback", with: Faker::Lorem.paragraph
    page.execute_script("$('#submit').click()")

    expect(page).to have_content(@artisan.firstname)
  end
end
