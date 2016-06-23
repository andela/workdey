require "rails_helper"

RSpec.describe Task, type: :model do
  before :each do
    seed = Seed.new
    seed.create_all
  end
  let(:user) { User.first }
  let(:user_email) { user.email }
  let(:user_street) { user.street_address }
  let(:user_city) { user.city }
  let(:taskees) { Task.first.users }

  describe ".current_user_city_street" do
    context "should set the user address given the right user email" do
      let(:user_email) { user.email }
      it do
        expect(Task.current_user_city_street(user_email)).
          to eq "%#{user_street}%"
      end
    end
  end

  describe ".get_taskees_nearby" do
    it "should return two taskees that match the exact city and street " do
      expect(Task.get_taskees_nearby(taskees, user_street, user_city).count).
        to eq 2
    end
  end

  describe ".get_taskees" do
    context "return nil when the wrong keyword is passed" do
      it { expect(Task.get_taskees("Marketting", user_email)).to eq nil }
    end
    context "returns an array of taskees nearby with the correct Keyword" do
      it { expect(Task.get_taskees("cleaning", user_email).count).to eq 2 }
    end
  end
end
