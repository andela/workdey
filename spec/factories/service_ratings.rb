FactoryGirl.define do
  factory :service_rating do
    rating Faker::Number.between(1, 5)
    private_feedback Faker::Lorem.paragraph
    public_feedback Faker::Lorem.paragraph
    category ServiceRating.categories[:tasker_to_artisan]
    service
  end
end
