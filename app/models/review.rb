class Review < ActiveRecord::Base
  belongs_to :reviewer, class_name: "User", foreign_key: :reviewer_id
  belongs_to :reviewee, class_name: "User", foreign_key: :reviewee_id
  belongs_to :task_management
  has_many :review_comments

  validates :review, presence: true
  validate :presence_of_rating
  validate :presence_of_reviewee
  validate :presence_of_task

  def presence_of_task
    unless task_management_id
      errors[:no_task] = " -  Please select a task"
    end
  end

  def presence_of_reviewee
    unless reviewee_id
      errors[:reviewee] = " -  Please select someone to review"
    end
  end

  def presence_of_rating
    unless rating.to_i >= 1
      errors[:no_rating] = " -  Please do not forget to include a rating"
    end
  end
end
