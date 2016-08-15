# frozen_string_literal: true
FactoryGirl.define do
  factory :task do
    name Faker::Company.name
    price Faker::Commerce.price(2000..3000).to_s
    price_range [
      Faker::Commerce.price(2000..3000).to_s,
      Faker::Commerce.price(3001..4000).to_s
    ]
    description Faker::Lorem.paragraph(3)
    start_date Date.today
    end_date 1.day.from_now
    location Faker::Address.city
  end
end
