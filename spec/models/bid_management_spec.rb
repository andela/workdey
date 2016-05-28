require "rails_helper"

RSpec.describe BidManagement, type: :model do
  it { is_expected.to belong_to(:bidding) }
  it { is_expected.to belong_to(:taskee).class_name("User") }
end
