require "rails_helper"

RSpec.describe "User Signup", type: :feature do
  before(:all) do
    @firstname = Faker::Name.first_name
    @lastname = Faker::Name.last_name
    @email = Faker::Internet.free_email
    @password = Faker::Internet.password
  end

  scenario "when user tries to sign up with valid data" do
    sign_up(@firstname, @lastname, @email, @password)

    expect(page).to have_content "Hi, #{@firstname} #{@lastname}"
  end

  scenario "when user tries to sign up with an email that has been taken" do
    sign_up(@firstname, @lastname, @email, @password)
    Capybara.reset_sessions!
    visit root_path
    sign_up(
      Faker::Name.first_name,
      Faker::Name.last_name,
      @email, Faker::Internet.password
    )

    within("div.error-explanation") do
      expect(page).to have_content "Email has already been taken"
    end
  end

  scenario "when user tries to sign up with names less than 2" do
    sign_up("a", "b", Faker::Internet.free_email, @password)

    within("div.error-explanation") do
      expect(page).to have_content "Firstname is too short "\
        "(minimum is 2 characters)"
      expect(page).to have_content "Lastname is too short "\
        "(minimum is 2 characters)"
    end
  end

  scenario "when user tries to sign up with password less than 8" do
    sign_up(@firstname, @lastname, Faker::Internet.free_email, "0123456")

    within("div.error-explanation") do
      expect(page).to have_content "Password is too short "\
        " (minimum is 8 characters)"
    end
  end

  def sign_up(firstname, lastname, email, password)
    visit signin_path
    click_link "Sign up"

    fill_in "user_firstname", with: firstname
    fill_in "user_lastname", with: lastname
    fill_in "user_email", with: email
    fill_in "user_password", with: password
    click_button "Create my account"
  end
end
