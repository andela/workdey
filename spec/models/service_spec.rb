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

  describe "assign and unassign" do
    it "assigns artisan to service" do
      user = create(:user)
      service.assign(user)
      expect(service.artisan_id).to eq(user.id)
      expect(service.status).to eq("assigned")
    end

    it "unassigns artisan from service" do
      service.unassign
      expect(service.artisan_id).to eq(nil)
      expect(service.status).to eq("unassigned")
    end
  end
end
