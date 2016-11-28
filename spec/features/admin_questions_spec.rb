require "rails_helper"

RSpec.feature "Admin Manage Questions", type: :feature do
  before(:each) do
    admin = create(:user, user_type: "admin")
    stub_current_user(admin)
  end

  scenario "Admin visits Manage Questions page" do
    question = create(:question)
    visit admin_questions_path
    expect(page).to have_content(question.question)
  end

  scenario "Admin creates a new question with valid input" do
    text = Faker::Lorem.sentence
    submit_question(text)
    expect(page).to have_content("Question successfully saved.")
    expect(page).to have_content(text)
  end

  scenario "Admin creates new question with invalid input" do
    submit_question("")
    expect(page).to have_content("1 error found. Please resolve.")
  end

  scenario "Admin previews questionnaire" do
    question = create(:question)
    visit preview_admin_questions_path
    expect(page).to have_content(question.question)
  end

  def submit_question(question)
    visit new_admin_question_path
    fill_in "Question", with: question
    click_button "Save"
  end
end
