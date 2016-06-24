require "rails_helper"

RSpec.describe Review, type: :model do
  it "" do
    is_expected.to belong_to(:reviewer).class_name("User").
      with_foreign_key(:reviewer_id)
  end

  it "" do
    is_expected.to belong_to(:reviewee).class_name("User").
      with_foreign_key(:reviewee_id)
  end

  it { is_expected.to belong_to(:task_management) }

  it { is_expected.to validate_presence_of(:body) }

  it "" do
    is_expected.to validate_uniqueness_of(:body).
      with_message(" - That same review has been given before")
  end

  before(:all) do
    @review = build(:review)
  end

  it "is valid if necessary parameters are present" do
    expect(@review.valid?).to be true
  end

  it "requires the presence of a rating" do
    @review.rating = nil
    expect(@review.valid?).to be false
  end
end
