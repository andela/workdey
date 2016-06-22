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

  it { is_expected.to have_many(:review_comments) }

  it { is_expected.to validate_presence_of(:review) }

  it "" do
    is_expected.to validate_uniqueness_of(:review).
      with_message(" - That same review has been given before")
  end

  before(:all) do
    @review = build(:review)
  end

  it "is valid if necessary parameters are present" do
    expect(@review.valid?).to be true
  end

  describe "it validates presence of certain properties" do
    it "requires the presence of a rating" do
      @review.rating = nil
      expect(@review.valid?).to be false
    end

    it "requires the presence of a reviewee" do
      @review.reviewee = nil
      expect(@review.valid?).to be false
    end

    it "requires the presence of a task" do
      @review.task_management_id = nil
      expect(@review.valid?).to be false
    end
  end

  describe "#uniqueness_of_review" do
    before(:each) do
      @user = create(:user)
      @task = create(:task_management)
    end
    context "when a user has not reviewed a task before" do
      it "user can review a task" do
        review = build(
          :review,
          reviewer_id: @user.id,
          task_management_id: @task.id
        )
        expect(review.valid?).to be true
      end
    end

    context "when a user has reviewed a task before" do
      it "user cannot review task" do
        create(
          :review,
          reviewer_id: @user.id,
          task_management_id: @task.id
        )
        review = build(
          :review,
          reviewer_id: @user.id,
          task_management_id: @task.id
        )
        expect(review.valid?).to be false
        expect(review.errors.full_messages).
          to include("Not allowed  - You cannot review a task more than once")
      end
    end
  end
end
