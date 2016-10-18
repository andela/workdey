require "rails_helper"

feature "Artisan Questionnaire" do

  background do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "Log in without taking quiz" do
    let(:user) { create(:user, has_taken_quiz: false) }
    create(:question)
    log_in_with(user.email, user.password)
    expect(page).to have_content("Artisan Questionnaire")
  end
end
