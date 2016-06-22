require "rails_helper"

RSpec.describe Skillset, type: :model do
  it { is_expected.to belong_to(:user) }

  describe ".get_taskees" do
    before(:all) do
      @skillset = create(:skillset)
      @user = @skillset.user
    end

    context "when the supplied skillset is available in the database" do
      it "returns the user with the supplied skillset" do
        taskee = Skillset.get_taskees(@skillset.name).first
        expect(taskee.id).to eq @user.id
      end
    end

    context "when the supplied skillset is not available" do
      it "returns an empty array" do
        skillset = Faker::Lorem.word
        expect(Skillset.get_taskees(skillset)).to eq []
      end
    end
  end
end
