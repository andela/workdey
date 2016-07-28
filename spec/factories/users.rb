FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password }
    gender  "male"
    phone { Faker::PhoneNumber.phone_number }
    state  { Faker::Address.state }
    city { Faker::Address.city }
    image_url { Faker::Avatar.image }
    has_taken_quiz true
    user_type "tasker"
    street_address { Faker::Address.street_address }

    factory :user_with_tasks do
      transient do
        task_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:skillset, evaluator.task_count, user: user)
      end
    end
  end
end
