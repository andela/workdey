FactoryGirl.define do
  factory :response do
    response { { Faker::Lorem.sentence => Faker::Lorem.sentence } }
    user
  end
end
