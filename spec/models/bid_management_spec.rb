# frozen_string_literal: true
require "rails_helper"

RSpec.describe BidManagement, type: :model do
  it { is_expected.to belong_to(:bidding) }
  it { is_expected.to belong_to(:artisan).class_name("User") }
end
