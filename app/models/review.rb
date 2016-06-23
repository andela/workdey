class Review < ActiveRecord::Base
  belongs_to :reviewer, class_name: "User", foreign_key: :reviewer_id
  belongs_to :reviewee, class_name: "User", foreign_key: :reviewee_id
  belongs_to :task_management

  SAME_REVIEW = " - That same review has been given before"
  NO_TASK = " -  Please select a task"
  SELECT_REVIEWEE = " -  Please select someone to review"
  NO_RATING = " -  Please do not forget to include a rating"
  SAME_TASK = " - You cannot review a task more than once"

  validates :body, presence: true, uniqueness: { message: SAME_REVIEW }
  validate :presence_of_rating
  validate :presence_of_reviewee
  validate :presence_of_task

  def presence_of_task
    unless task_management_id
      errors[:no_task] = NO_TASK
    end
  end

  def presence_of_reviewee
    unless reviewee_id
      errors[:reviewee] = SELECT_REVIEWEE
    end
  end

  def presence_of_rating
    unless rating && rating.to_i >= 1
      errors[:no_rating] = NO_RATING
    end
  end
end
