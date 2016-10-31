require "rails_helper"

RSpec.describe ServiceAssignment, type: :model do
  it { is_expected.to belong_to(:service) }
  it { is_expected.to belong_to(:user) }

  describe "assigning to a service" do
    let(:service) { FactoryGirl.create(:service) }
    let(:artisan1) { FactoryGirl.create(:user) }
    let(:artisan2) { FactoryGirl.create(:user) }

    it "assigns service only to artisan with that skillset" do
      create(:artisan_skillset,
             skillset_id: service.skillset.id,
             artisan_id: artisan1.id)
      ServiceAssignment.assign(service)

      expect(service.artisan_id).to eq(artisan1.id)
      expect(service.artisan_id).to_not eq(artisan2.id)
    end

    context "when many artisans have the skill" do
      it "assigns to highest rated first" do
        create(:rating, rating: 5, user_id: artisan1.id)
        create(:rating, rating: 4, user_id: artisan2.id)
        create(:artisan_skillset,
               skillset_id: service.skillset.id,
               artisan_id: artisan1.id)
        create(:artisan_skillset,
               skillset_id: service.skillset.id,
               artisan_id: artisan2.id)
        ServiceAssignment.assign(service)

        expect(service.artisan_id).to eq(artisan1.id)
        expect(service.artisan_id).to_not eq(artisan2.id)

        ServiceAssignment.assign(service)

        expect(service.artisan_id).to eq(artisan2.id)
        expect(service.artisan_id).to_not eq(artisan1.id)
      end
    end
  end
end
