FactoryGirl.define do
  factory :skillset do
    user
    task
    name { Faker::Lorem.word }
  end
end
