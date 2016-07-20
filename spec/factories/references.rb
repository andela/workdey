FactoryGirl.define do
  factory :reference do
    taskee_id nil
    email { Faker::Internet.email }
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    relationship "Professional: I have worked with Ruth"
    skillsets { { "skills" => ["Plumbing"] } }
    confirmation_token { Faker::Lorem.characters(10) }
    done false
  end
end
