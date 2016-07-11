require "rails_helper"

RSpec.describe "Task Creation and Assignment", js: true, type: :feature do
  before(:each) do
    @taskee = create(:user, user_attr.merge(user_type: "taskee"))
    @taskee2 = create(:user, user_attr.merge(user_type: "taskee"))
    @tasker = create(:user, user_attr.merge(user_type: "tasker"))
    @skillset = create(:skillset, user: @taskee)
    @skillset2 = create(:skillset, name: @skillset.name, user: @taskee2)
  end

  describe "creating task with valid data" do
    scenario "when creating a Task with location" do
      new_task_helper(4000)
      fill_in "task[location]", with: "#{@taskee.street_address},"\
       " #{@taskee.city}"
      click_button "Create Task"
      page.all(".searched-taskee")[0].click
      click_link "ASSIGN TASK"
      expect(page).to have_content "You have assigned the task to a Taskee"
    end

    scenario "when creating a Task without location" do
      new_task_helper(4000)
      click_button "Create Task"
      expect(page).to have_content(@taskee.firstname)
      expect(page).to have_content(@taskee2.firstname)
      page.all(".searched-taskee")[0].click
      click_link "ASSIGN TASK"
      expect(page).to have_content "You have assigned the task to a Taskee"
    end
  end

  describe "creating a task with invalid data" do
    scenario "when creating a task with less than 2000" do
      new_task_helper(1599)
      click_button "Create Task"
      expect(page).to have_content "Price must be greater than or equal to 2000"
    end
  end

  def new_task_helper(price)
    log_in_with(@tasker.email, @tasker.password)
    visit new_task_path
    fill_in "task[name]", with: Faker::Lorem.word
    fill_in "task[price]", with: price

    end_date = Date.tomorrow.in_time_zone.to_i * 1000
    start_date = Date.today.in_time_zone.to_i * 1000
    page.execute_script("$('.start_date')\
                        .pickadate('picker').set('select', #{start_date})")
    page.execute_script("$('.end_date')\
                        .pickadate('picker').set('select', #{end_date})")
    fill_in "task[time]", with: "4:00 PM"
    fill_in "task[description]", with: Faker::Lorem.sentence
    page.execute_script(
      "document.getElementById('skillsets').value = '#{@skillset.name}'"
    )
    page.execute_script('$("#assign").attr("checked", "checked")')
  end
end
