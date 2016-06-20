FactoryGirl.define do
  factory :notification do
    message "MyString"
    read false
    user nil
  end
end
