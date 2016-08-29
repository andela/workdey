FactoryGirl.define do
  factory :task_management do
    task_id 1
    tasker_id 1
    taskee_id 2
    description { Faker::Lorem.sentence }
    amount { Faker::Commerce.price(2000..50_000.0) }
    start_time Date.tomorrow
    end_time 2.days.from_now
  end
end
