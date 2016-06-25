require "rails_helper"

RSpec.describe Skillset, type: :model do
  it { is_expected.to belong_to(:user) }

  describe ".get_taskees" do
    context "when the supplied keyword is available in the database" do
      before(:each) do
        @skillset = create(:skillset)
        @user = @skillset.user
      end

      it "returns the user with the supplied skillset" do
        taskee = Skillset.get_taskees_and_skillsets(@skillset.name).first.first
        expect(taskee.id).to eq @user.id
      end

      it "returns the  object with the supplied skillset" do
        skillset = Skillset.get_taskees_and_skillsets(@skillset.name).last.first
        expect(skillset.id).to eq @skillset.id
      end
    end

    context "when the supplied skillset is not available" do
      it "returns an empty array" do
        skillset = Faker::Lorem.word
        expect(Skillset.get_taskees_and_skillsets(skillset).flatten).to eq []
      end
    end
  end
end
