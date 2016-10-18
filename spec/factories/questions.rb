FactoryGirl.define do
  factory :question do
    question Faker::Lorem.sentence
    required true
    options []
  end
end
