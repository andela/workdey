class Review < ActiveRecord::Base
  belongs_to :reviewer, class_name: "User", foreign_key: :reviewer_id
  belongs_to :reviewee, class_name: "User", foreign_key: :reviewee_id
  belongs_to :task_management

  SAME_REVIEW = " - That same review has been given before".freeze
  NO_RATING = " -  Please do not forget to include a rating".freeze

  validates :body, presence: true, uniqueness: { message: SAME_REVIEW }
  validate :presence_of_rating

  def presence_of_rating
    unless rating && rating.to_i >= 1
      errors[:no_rating] = NO_RATING
    end
  end
end
