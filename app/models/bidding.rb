class Bidding < ActiveRecord::Base
  belongs_to :task
  accepts_nested_attributes_for :task
  validates :description, presence: true, length: { minimum: 10 }
end
