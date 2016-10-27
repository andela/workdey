require "rails_helper"

RSpec.describe Service, type: :model do
  subject(:service) { create(:service) }

  describe "associations" do
    it { should belong_to(:tasker) }
    it { should belong_to(:artisan) }
    it { should belong_to(:skillset) }
  end

  describe "validates title" do
    it { should validate_presence_of :title }
  end

  describe "validates description" do
    it { should validate_presence_of :description }
  end

  describe "validates skillset_id" do
    it { should validate_presence_of :skillset_id }
  end

  describe "validates start_date" do
    it { should validate_presence_of :start_date }
  end

  describe "validates end_date" do
    it { should validate_presence_of :end_date }
  end

  describe "validates duration" do
    it { should validate_presence_of :duration }
  end

  describe "validates status" do
    it { should validate_presence_of :status }
  end
end
