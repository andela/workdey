FactoryGirl.define do
  factory :user do
    firstname 'Mayowa'
    lastname 'Pitan'
    email 'mayowa.pitan@andela.com'
    password 'andela rails'

    factory 'user_with_tasks' do
      transient do
        task_count 1
      end

      after(:create) do |user, evaluator|
        create_list(:skillset, evaluator.task_count, user: user)
      end
    end
  end
end

