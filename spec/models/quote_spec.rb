require 'rails_helper'

RSpec.describe Quote, type: :model do
  describe "associations" do
    it { should belong_to(:artisan) }
  end
  describe "validates quoted value" do
    it { should validate_presence_of(:quoted_value) }
  end
  describe "validates status" do
    it { should validate_presence_of(:status) }
  end
end
