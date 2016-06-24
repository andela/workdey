FactoryGirl.define do
  factory :review do
    task_management_id Faker::Number.between(1, 10)
    reviewer_id Faker::Number.between(1, 10)
    reviewee_id Faker::Number.between(1, 10)
    body { Faker::Lorem.paragraph }
    rating Faker::Number.between(1, 6)
    response { Faker::Lorem.paragraph }
  end
end
