require "rails_helper"
RSpec.feature "regret email" do
  before(:each) do
    @user = create(:user, user_type: "admin")
    stub_current_user(@user)
  end

  scenario "Admin can edit regret email for rejected applicants" do
    @rejected_user = create(:user, user_type: "artisan", status: "no")
    visit certify_artisans_admin_ratings_path
    click_on "reject"
    expect(page).to have_content "Edit Email"
  end

  scenario "Admin cannot send email if there are no rejected applicants" do
    visit certify_artisans_admin_ratings_path
    click_on "reject"
    expect(page).to have_css("a.disabled")
  end
end
