FactoryGirl.define do
  factory :skillset do
    user
    name { Faker::Lorem.word }
  end
end
