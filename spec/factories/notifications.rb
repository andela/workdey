FactoryGirl.define do
  factory :notification do
    message { Faker::Lorem.sentence(6) }
    read false
    receiver_id nil
    sender_id nil
    notifiable_id nil
    notifiable_type nil
  end
end
