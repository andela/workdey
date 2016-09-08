# frozen_string_literal: true
class Bid < ActiveRecord::Base
  belongs_to :task
  belongs_to :user, class_name: "User"
  has_many :notifications, as: :notifiable

  validates :description, :price, :start_date, :end_date, :user_id,
            :task_id, presence: true

  validate  :price_validation
  self.per_page = 10

  def price_validation
    errors.add(:price, "Price should be greater than $2,000") if price < 2000
  end
end
