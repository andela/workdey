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

    @statuses = %w(done active inactive rejected)

    @tasker = create(:user, user_type: "tasker")
    @taskee = create(:user, taskee_attr)

    @statuses.each do |status|
      create(:task_management,
             task_desc: Faker::Lorem.sentence,
             status: status)
    end
  end

  def user_attr
    {
      street_address: Faker::Address.street_address,
      has_taken_quiz: true,
      confirmed: true,
      phone: nil
    }
  end

  def task_attr
    {
      start_date: Date.today,
      end_date: 1.day.from_now,
      price: 5000,
      description: Faker::Lorem.sentence,
      tasker_id: 3
    }
  end

  def new_task_helper(price)
    log_in_with(tasker.email, tasker.password)
    visit new_task_path
    fill_in "task[name]", with: Faker::Lorem.word
    fill_in "task[price]", with: price

    end_date = Date.tomorrow.in_time_zone.to_i * 1000
    start_date = Date.today.in_time_zone.to_i * 1000
    page.execute_script("$('.start_date')\
                        .pickadate('picker').set('select', #{start_date})")
    page.execute_script("$('.end_date')\
                        .pickadate('picker').set('select', #{end_date})")
    fill_in "task[description]", with: Faker::Lorem.sentence
  end
end
