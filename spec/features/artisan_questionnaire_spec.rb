require "rails_helper"

feature "Artisan Questionnaire" do
  let(:user) do
    create(
      :user,
      user_type: "artisan",
      confirmed: true,
      has_taken_questionnaire: false
    )
  end

  scenario "Log in without taking questionnaire" do
    create(:question)
    log_in_with(user.email, user.password)
    expect(page).to have_content("Artisan Questionnaire")
  end
end
