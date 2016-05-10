FactoryGirl.define do
  factory :task_management do
    task_id 1
    tasker_id 1
    taskee_id 2
    task_desc Faker::Lorem.sentence
    amount "9000"
    start_time Date.tomorrow
    end_time 2.days.from_now
    status "done"
    taskee_notified true
    viewed true
    tasker_notified true
  end
end
