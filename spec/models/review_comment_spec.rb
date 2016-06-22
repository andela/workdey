require "rails_helper"

RSpec.describe ReviewComment, type: :model do
  it { is_expected.to belong_to (:review) }
  it { is_expected.to belong_to (:user) }
end
