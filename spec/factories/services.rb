FactoryGirl.define do
  factory :service do
    title Faker::Lorem.sentence
    description Faker::Lorem.paragraph
    start_date Date.today
    end_date Date.parse(1.day.from_now.to_s)
    duration Faker::Number.decimal(2, 2)
    status "unassigned"
    skillset
  end
end
