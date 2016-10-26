FactoryGirl.define do
  factory :service do
    tasker_id 1
    artisan_id 1
    skillset_id 1
    title "MyString"
    description "MyString"
    start_date "2016-10-26 21:00:05"
    end_date "2016-10-26 21:00:05"
    duration "9.99"
    status 1
  end
end
