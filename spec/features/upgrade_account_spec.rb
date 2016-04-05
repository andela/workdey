require 'rails_helper'

feature "Account type" do

  before do
    Capybara.default_driver = :selenium
    workdey_data = Seed.new
    workdey_data.create_all
  end

  context "Tasker" do
    before do
      login_tasker
    end

    scenario "User logs in and is directed to dashboard" do
      expect(page).to have_content("Welcome Chinedu Daniel")
    end

    scenario "User has option to upgrade account" do
      expect(page).to have_selector("a > li", text: "Account Upgrade")
    end

    scenario "User can click on upgrade button and be redirected to user plans page" do
      click_link "Account Upgrade"
      expect(page).to have_current_path("/user_plans")
    end

    # scenario "User can upgrade to a medial account" do
    # end

    # scenario "User can upgrade to a maestro account" do
    # end
  end

  # context "Taskee" do
  #   scenario "User logs in and is directed to dashboard" do
  #     login_taskee
  #     expect(page).to have_content("Welcome Olaide Ojewale")
  #   end

  #   scenario "User has option to upgrade account" do
  #   end

  #   scenario "User can click on upgrade button and be redirected to user plans page" do
  #   end

  #   scenario "User can upgrade to a medial account" do
  #   end

  #   scenario "User can upgrade to a maestro account" do
  #   end
  # end

  # context "Medial tasker" do
  #   scenario "User can assign taskees a maximum of 50 tasks" do
  #   end

  #   scenario "User can filter taskees by reputation" do
  #   end

  #   scenario "User can assign an unlimited number of tasks to taskees" do
  #   end

  #   scenario "User can rate taskee on quality of tasks" do
  #   end
  # end

  # context "Maestro tasker" do
  #   scenario "User can assign taskees an unlimited number of tasks" do
  #   end

  #   scenario "User can filter taskess by reputation" do
  #   end

  #   scenario "User can assign an unlimited number of tasks to taskess" do
  #   end

  #   scenario "User can rate taskees on quality of tasks" do
  #   end
  # end

  # context "Novice taskee" do
  #   scenario "User can receive a maximum of 10 tasks" do
  #   end

  #   scenario "User has a limited number of tasks" do
  #   end
  # end

  # context "Medial taskee" do
  #   scenario "User can receive a maximum of 50 task assignments" do
  #   end

  #   scenario "User can receive an unlimited number of task types" do
  #   end

  #   scenario "User can earn reputation from rating by 20 taskers" do
  #   end
  # end

  # context "Maestro taskee" do
  #   scenario "User can receive more than 50 task assignments" do
  #   end

  #   scenario "User can receive an unlimited number of task types" do
  #   end

  #   scenario "User can earn reputation from rating by more than 20 taskers" do
  #   end
  # end

  def login_taskee
    login_user('olaide.ojewale@andela.com', '1234567890')
  end

  def login_tasker
    login_user('chinedu.daniel@andela.com', '1234567890')
  end

  def login_user(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
  end

end
