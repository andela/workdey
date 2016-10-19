require "rails_helper"

feature "Artisan Questionnaire" do

  let(:user) do
    create(:user, user_type: "taskee", confirmed: true, has_taken_questionnaire: false)
  end

  background do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "Log in without taking questionnaire" do
    create(:question)
    log_in_with(user.email, user.password)
    expect(page).to have_content("Artisan Questionnaire")
  end
end
