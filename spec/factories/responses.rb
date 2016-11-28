FactoryGirl.define do
  factory :response do
    response { { Faker::Lorem.sentence => Faker::Lorem.paragraph } }
    user
    to_create { |instance| instance.save(validate: false) }
  end
end
