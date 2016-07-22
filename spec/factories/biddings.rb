# frozen_string_literal: true
FactoryGirl.define do
  factory :bidding do
    name "Cleaning"
    description { Faker::Lorem.sentence(5) }
    price_range "2000"
    tasker_id nil
  end
end
