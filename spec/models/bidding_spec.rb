# frozen_string_literal: true
require "rails_helper"

RSpec.describe Bidding, type: :model do
  it { is_expected.to belong_to(:task) }
  it { is_expected.to belong_to(:tasker) }
  it { should validate_presence_of(:description) }
  it { should validate_length_of(:description).is_at_least(10) }
  it { is_expected.to have_many(:bid_managements) }
end
