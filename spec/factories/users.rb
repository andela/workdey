FactoryGirl.define do
  factory :user do
    firstname "Mayowa"
    lastname "Pitan"
    email "mayowa.pitan@andela.com"
    password "andela rails"
    password_confirmation "andela rails"
    user_type "tasker"
    has_taken_quiz true
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
