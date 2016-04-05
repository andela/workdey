require "rails_helper"

RSpec.describe Skillset, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:task) }
end
