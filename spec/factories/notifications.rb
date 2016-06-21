FactoryGirl.define do
  factory :notification do
    message { Faker::Lorem.sentence(6) }
    read false
    receiver nil
  end
end
