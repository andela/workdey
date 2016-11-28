require "rails_helper"

RSpec.describe Question, type: :model do
  it { should validate_presence_of(:question) }

  describe "before_validation" do
    it "sets rank on create" do
      question = create(:question)

      expect(question).to validate_presence_of(:rank)
    end
  end

  describe "#rank" do
    it "autoincrements rank" do
      question = create(:question)
      question2 = create(:question)

      expect(question2.rank).to be > question.rank
    end
  end

  describe "#promote_rank" do
    context "when it is rank 1" do
      it "keeps its rank" do
        question = create(:question)

        expect { question.promote_rank }.to change { question.rank }.by(0)
      end
    end

    context "when it is not rank 1" do
      it "changes the ranks of itself and one above it" do
        create(:question)
        question2 = create(:question)
        question2.promote_rank

        expect(question2.rank).to eq(1)
      end
    end
  end

  describe "#demote_rank" do
    context "when it is rank last" do
      it "keeps its rank" do
        question = create(:question)

        expect { question.demote_rank }.to change { question.rank }.by(0)
      end
    end

    context "when it is not rank last" do
      it "changes the ranks of itself and one below it" do
        question = create(:question)
        create(:question)
        question.demote_rank

        expect(question.rank).to eq(2)
      end
    end
  end
end
