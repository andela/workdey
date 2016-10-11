require "rails_helper"

feature "Artisan Questionnaire" do
  let(:email) { "bernard.kanyolo+workdey1@andela.com" }
  let(:password) { "1234567890" }

  background do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "Log in without taking quiz" do
    sign_in
    expect(page).to have_content("Artisan Questionnaire")
  end

  def sign_in
    visit signin_path
    within("div > form") do
      fill_in "session_email", with: email
      fill_in "session_password", with: password
    end
    click_button "Sign in"
  end

  def fill_questionnaire

  end
end
