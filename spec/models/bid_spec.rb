# frozen_string_literal: true
require "rails_helper"

RSpec.describe Bid, type: :model do
  subject { create(:bid_user_task) }

  describe "Model validation" do
    it "factory should be valid" do
      should be_valid
    end
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:task_id) }
    it { should belong_to(:user) }
    it { should belong_to(:task) }
  end
end
