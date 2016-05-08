FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.first_name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password }
    gender "male"
    phone "1234567890"
    state "lagos"
    city "Yaba"
    image_url "http://res.cloudinary.com/dxoydowjy/image/upload/v1452076402"

    factory "user_with_tasks" do
      transient do
        task_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:skillset, evaluator.task_count, user: user)
      end
    end
  end
end
