# require "rails_helper"
#
# RSpec.describe "Task Creation and Assignment", type: :feature do
#   before(:all) do
#     Capybara.default_driver = :selenium
#     attributes = user_attr.merge(user_type: "tasker")
#     @taskee = create(:user, user_attr.merge(user_type: "taskee"))
#     @tasker = create(:user, attributes)
#     @skillset = create(:skillset, user: @taskee)
#   end
#
#
#     scenario "when creating a Task with location" do
#       log_in_with(@tasker.email, @tasker.password)
#       visit new_task_path
#       fill_in "task[name]", with: Faker::Lorem.word
#       fill_in "task[price]", with: 5000
#
#       date = Date.tomorrow.in_time_zone.to_i * 1000
#       page.execute_script("$('.start_date')\
#                           .pickadate('picker').set('select', #{date})")
#       page.execute_script("$('.end_date')\
#                           .pickadate('picker').set('select', #{date})")
#       fill_in "task[time]", with: "4:00 PM"
#       fill_in "task[location]", with: "#{@taskee.street_address}, #{@takee.city}"
#       fill_in "task[description]", with: Faker::Lorem.sentence
#       fill_in "task[skillsets]", with: @skillset.name
#       page.choose('assign')
#
#       click_button "Create Task"
#
#       expect(page).to have
#     end
# end
