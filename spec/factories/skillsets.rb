FactoryGirl.define do
  factory :skillset do
    user
    task
    name { Faker::Name.name }
  end
end
