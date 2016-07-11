require "rails_helper"

feature "SignUp" do
  let(:email) { "ruth.chukwumam@andela.com" }
  let(:password) { "1234567890" }

  background do
    # Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  scenario "Take the taskee quiz" do
    sign_in
    click_button "I'm ready!"
    answer_quiz
    click_link "Proceed"
    expect(page).to have_content("Confirm your email address")
  end

  def answer_quiz
    right_answers_arr = [2, 2, 3, 2, 1, 2, 3, 2, 2, 4, 2]
    right_answers_arr.each do |ans|
      find(:xpath, "//label[@for='radio #{ans}']").click
      sleep(1.2)
      click_button "Submit"
      sleep(1.2)
      click_button "Next"
    end
  end

  def sign_in
    visit signin_path
    within("div > form") do
      fill_in "session_email", with: email
      fill_in "session_password", with: password
    end
    click_button "Sign in"
  end
end
