FactoryGirl.define do
  factory :enquiry do
    question { Faker::Lorem.sentence }
    response { Faker::Lorem.sentence }
  end
end
