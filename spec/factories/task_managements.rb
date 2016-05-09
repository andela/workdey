FactoryGirl.define do
  factory :task_management do
    start_time Time.now
    end_time 2.days.from_now
    task_id 1
    tasker_id 1
    taskee_id 2
    amount 5000
  end
end
