require "rails_helper"

RSpec.describe ReviewComment, type: :model do
  it { is_expected.to belong_to(:review) }
  it { is_expected.to belong_to(:user) }
  describe "#presence_of_body" do
    before(:each) do
      @review_comment = build(:review_comment)
    end

    it "can be created if comment has a body" do
      expect(@review_comment.body.length).to be > 1
      expect(@review_comment.valid?).to be true
    end

    it "cannot be created if comment does not have a body" do
      @review_comment.body = ""
      expect(@review_comment.valid?).to be false
    end
  end
end
