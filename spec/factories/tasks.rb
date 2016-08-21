FactoryGirl.define do
  factory :task do
    name { Faker::Company.name }
    description Faker::Lorem.paragraph(3)
    start_date Date.today
    end_date 1.day.from_now
    location Faker::Address.city
    price_range [
      Faker::Commerce.price(2000..3000).to_s,
      Faker::Commerce.price(3001..5000).to_s
    ]
  end
end
