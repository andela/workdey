FactoryGirl.define do
  factory :quote do
    quoted_value 1
    status 1
    artisan
    service

    after(:build) { |quote| quote.artisan.update(confirmed: true) }
  end
end
