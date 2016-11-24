class Question < ActiveRecord::Base
  validates :question, presence: true
  validates :rank, presence: true, uniqueness: true
  validate :question_options_provided_not_empty
  validate :attributes_for_closed_questions_unticked_for_open_questions
  validate :only_one_option_must_include_other
  before_validation :set_rank, on: :create
  after_destroy :normalize_ranks

  def promote_rank
    next_higher = Question.find_by(rank: rank - 1)
    if next_higher
      next_higher.increment!(:rank)
      decrement!(:rank)
    end
  end

  def demote_rank
    next_lower = Question.find_by(rank: rank + 1)
    if next_lower
      next_lower.decrement!(:rank)
      increment!(:rank)
    end
  end

  def self.ranked
    Question.order(rank: :asc)
  end

  private

  def question_options_provided_not_empty
    options.each_with_index do |option, index|
      errors.add(:options_empty, "option #{index}") if option.blank?
    end
  end

  def attributes_for_closed_questions_unticked_for_open_questions
    errors.add(
      :multiple,
      "'Enable Multiple Selections' only for questions with options"
    ) if options.empty? && can_select_multiple?
    errors.add(
      :other,
      "'Enable Write-In Option (Other)' only for questions with options"
    ) if options.empty? && include_other?
    errors.add(
      :other,
      "'Enable Write-In Option (Other)' only for questions with multiple
          possible options selectable"
    ) if !can_select_multiple? && include_other?
  end

  def only_one_option_must_include_other
    errors.add(
      :options_count,
      "Either add more options, enable write-in option or
        make the question open by removing all options."
    ) if options.count == 1 && !include_other?
  end

  def set_rank
    max = Question.maximum(:rank)
    self.rank = max + 1 if max
  end

  def normalize_ranks
    (1...Question.maximum(:rank)).each do |rank|
      Question.find_by(rank: rank + 1).update(rank: rank) unless
        Question.find_by(rank: rank)
    end
  end
end
