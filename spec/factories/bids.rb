# frozen_string_literal: true
FactoryGirl.define do
  factory :bid do
    description Faker::Lorem.paragraph(3)
    start_date Date.today
    end_date 1.day.from_now
    task_id nil
    user_id nil
    price Faker::Commerce.price(2000..3000)

    factory :bid_user_task do
      transient do
        user_id { create(:user_with_tasks).id }
        task_id { create(:task).id }
      end

      user { FactoryGirl.create(:user_with_tasks, user_type: "taskee") }
      task do
        FactoryGirl.create(:task, tasker_id: FactoryGirl.create(:user).id)
      end
    end
  end
end
