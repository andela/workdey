module Helpers
  def log_in_with(email, password)
    visit signin_path
    fill_in "session_email", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
  end

  def taskee_stub
    taskee_attr = {
      confirmed: true,
      has_taken_quiz: true,
      user_type: "taskee"
    }

    @tasker = create(:user, user_type: "tasker")
    @taskee = create(:user, taskee_attr)

    %w(done active inactive rejected).each do |status|
      create(:task_management,
             task_desc: Faker::Lorem.sentence,
             status: status)
    end
  end
end
