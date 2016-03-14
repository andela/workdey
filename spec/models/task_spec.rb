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
    let(:user_email) { user.email }
    it "should return user address" do
      expect(Task.current_user_city_street(user_email)).to be_a String
      expect(Task.current_user_city_street(user_email)).
        to eq("%#{user_street}%")
    end
  end

  describe ".get_taskees_nearby" do
    it "should return an array" do
      expect(Task.get_taskees_nearby(taskees, user_street, user_city)).
        to be_an ActiveRecord::AssociationRelation
    end
  end

  describe ".get_taskees" do
    context "return nil when the wrong keyword is passed" do
      it { expect(Task.get_taskees("Marketting", user_email)).to eq nil }
    end
    context "returns an array of taskees nearby with the correct Keyword" do
      it { expect(Task.get_taskees("Cleaning", user_email)).to be_an Array }
    end
  end
end
