FactoryGirl.define do
  factory :skillset do
    user
    name { Faker::Name.name }
  end
end
