require "rails_helper"

RSpec.describe Reference, type: :model do
  it { should belong_to(:artisan).class_name("User") }
  it { should validate_presence_of(:firstname) }
  it { should validate_presence_of(:lastname) }
  it { should validate_presence_of(:relationship) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:skillsets) }
end
