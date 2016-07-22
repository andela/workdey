FactoryGirl.define do
  factory :task do
    name Faker::Company.name
    price Faker::Commerce.price(2000..3000)
    description Faker::Lorem.paragraph(3)
    start_date Date.today
    end_date 1.day.from_now
    location Faker::Address.city
  end
end
