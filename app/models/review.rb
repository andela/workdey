class Review < ActiveRecord::Base
  belongs_to :reviewer, class_name: "User", foreign_key: :reviewer_id
  belongs_to :reviewee, class_name: "User", foreign_key: :reviewee_id
  belongs_to :task_management
  has_many :review_comments
end
