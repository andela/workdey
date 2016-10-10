class Rating < ActiveRecord::Base
  belongs_to :user
  validates :comment, presence: true
  validates :rating, presence: true
end
