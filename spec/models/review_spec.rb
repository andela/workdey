require "rails_helper"

RSpec.describe Review, type: :model do
  describe "a review should belong to a user" do
    it "should belong to a reviewer" do
      is_expected.to belong_to(:reviewer).class_name("User").
        with_foreign_key(:reviewer_id)
    end

    it "should belong to a reviewee" do
      is_expected.to belong_to(:reviewee).class_name("User").
        with_foreign_key(:reviewee_id)
    end
  end

  describe "a review should belong to a task_management" do
    it { is_expected.to belong_to(:task_management) }

    it { is_expected.to validate_presence_of(:body) }
  end

  it "should be unique" do
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
