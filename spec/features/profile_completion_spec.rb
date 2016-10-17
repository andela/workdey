require "rails_helper"

RSpec.describe "Profile completion meter" do
  let(:user) { create(:user, user_attr) }
  let(:user_attr) do
    {
      user_type: "artisan",
      has_taken_quiz: true,
      confirmed: true,
      phone: nil
    }
  end

  scenario "when a User logs into their account" do
    log_in_with(user.email, user.password)
    expect(page).to have_content "Welcome #{user.firstname}"

    within("div.profile-meter") do
      expect(page).to have_content "73%"
    end
  end

  scenario "users after updating their account, their profile completeness "\
    " should increase" do
    log_in_with(user.email, user.password)

    within("div.profile-meter") do
      expect(page).to have_content "73%"
    end

    click_link "Complete Your Profile"
    fill_in "phone", with: Faker::PhoneNumber.phone_number
    fill_in "street_address", with: Faker::Address.street_name
    click_button "UPDATE PROFILE"
    visit dashboard_path


    within("div.profile-meter") do
      expect(page).to have_content "82%"
    end
  end
end
