FactoryGirl.define do
  factory :user do
    firstname "Mayowa"
    lastname "Pitan"
    email "mayowa.pitan@andela.com"
    password "andela rails"
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
