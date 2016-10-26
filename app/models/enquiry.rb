class Enquiry < ActiveRecord::Base
  belongs_to :user
  has_many :notifications, as: :notifiable

  validates :question, presence: true

end
