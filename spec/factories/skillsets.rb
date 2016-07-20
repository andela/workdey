FactoryGirl.define do
  factory :skillset do
    user
    # task nil
    name { Faker::Lorem.word }
  end
end
