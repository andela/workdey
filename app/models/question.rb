class Question < ActiveRecord::Base
  validates :question, presence: true
  validates :required, inclusion: [true, false]
  validates :rank, presence: true, uniqueness: true
  before_validation :set_rank, on: :create
  before_create :set_rank
  after_destroy :normalize_ranks

  def promote_rank
    next_higher = Question.find_by(rank: rank - 1)
    if next_higher
      next_higher.update(rank: -1)
      update(rank: rank - 1)
      next_higher.update(rank: rank + 1)
    end
  end

  def demote_rank
    next_lower = Question.find_by(rank: rank + 1)
    if next_lower
      next_lower.update(rank: -1)
      update(rank: rank + 1)
      next_lower.update(rank: rank - 1)
    end
  end

  private

  def set_rank
    self.rank = Question.maximum(:rank) + 1
  end

  def normalize_ranks
    (1...Question.maximum(:rank)).each do |rank|
      Question.find_by(rank: rank + 1).update(rank: rank) unless
        Question.find_by(rank: rank)
    end
  end
end
