module Helpers
  def log_in_with(email, password)
    visit signin_path
    fill_in "session[email]", with: email
    fill_in "session_password", with: password
    click_button "Sign in"
  end

  def stub_current_user(user)
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(user)
  end

  def artisan_stub
    artisan_attr = {
      confirmed: true,
      has_taken_quiz: true,
      user_type: "artisan",
      status: 0
    }

    @tasker = create(:user, user_type: "tasker")
    @artisan = create(:user, artisan_attr)
    status_stub
  end

  def status_stub
    @statuses = %w(done active inactive rejected)
    @statuses.each do |status|
      create(:task_management,
             description: Faker::Lorem.sentence,
             status: status,
             paid: true)
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

  def new_task_helper(price)
    log_in_with(@user.email, @user.password)
    visit new_task_path
    fill_in "task_name", with: Faker::Lorem.word
    fill_in "min_price", with: price.to_s
    fill_in "max_price", with: (price + 10).to_s

    end_date = Date.tomorrow.in_time_zone.to_i * 1000
    start_date = Date.today.in_time_zone.to_i * 1000
    page.execute_script("$('.start_date')\
                        .pickadate('picker').set('select', #{start_date})")
    page.execute_script("$('.end_date')\
                        .pickadate('picker').set('select', #{end_date})")
    find("div.select-wrapper input").click
    sleep(0.2)
    first("div.select-wrapper li", text: @skillset.name).click
    fill_in "task[description]", with: Faker::Lorem.sentence
  end

  def search_helper(artisan, skillset)
    log_in_with(artisan.email, artisan.password)
    find("#search").click
    fill_in "need", with: skillset.name
    find("#my-input-field").native.send_keys(:return)
  end

  def parsed_response
    JSON.parse(response.body)
  end

  def submit_request(start_date, end_date)
    click_link "Submit Request"
    fill_in "service_title", with: "Quo possimus sint"
    fill_in "service_description", with: "Eligendi consectetur fugit sunt
                                 sapiente.Libero voluptates necessitatibus
                                 saepe corporis aliquid repellendus esse.
                                 Nostrum ea quia eos sed beatae.Debitis aut
                                 molestiae laborum nemo aut ea nisi."
    select("Carpentry", from: "service_skillset_id")
    page.execute_script("$('#service_start_date')\
                        .pickadate('picker').set('select', '#{start_date}')")
    page.execute_script("$('#service_end_date')\
                        .pickadate('picker').set('select', '#{end_date}')")
    page.execute_script("$('#commit').click()")
  end
end
