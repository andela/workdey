class Bidding < ActiveRecord::Base
  belongs_to :task
  belongs_to :tasker, class_name: "User"
  has_many :bid_managements

  validates :description, presence: true, length: { minimum: 10 }
end
