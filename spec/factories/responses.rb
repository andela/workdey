FactoryGirl.define do
  factory :response do
    response { { Faker::Lorem.sentence => Faker::Lorem.paragraph } }
    user
  end
end
