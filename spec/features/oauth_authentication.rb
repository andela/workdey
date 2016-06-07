require "rails_helper"

RSpec.feature "Oauth Authentication" do
  before do
    OmniAuth.config.test_mode = true
    Capybara.default_driver = :selenium
  end

  after do
    OmniAuth.config.test_mode = false
    OmniAuth.config.mock_auth[:google_oauth2] = nil
  end

  subject do
    OmniAuth.config.add_mock(
      :google_oauth2,
      provider: "google_oauth2",
      uid: Faker::Number.number(5),
      info: {
        name: Faker::Name.name,
        email: Faker::Internet.safe_email,
        image: Faker::Avatar.image
      }
    )
  end

  context "when a user signs up" do
    scenario "user clicks the google button" do
      subject
      visit signin_path
      click_link "Google"
      expect(page.current_path).to eql role_path
      expect(page).to have_content "I NEED HELP WITH TASKS"
      expect(page).to have_content "I WANT TO CARRY OUT TASKS"
    end
  end

  context "when a user logs in" do
    scenario "user clicks the google button" do
      User.first_or_create_from_oauth(subject).tap do |user|
        user.user_type = "tasker"
      end.save

      visit signin_path
      click_link "Google"

      expect(page).to have_content "Complete Your Profile"
    end
  end
end
