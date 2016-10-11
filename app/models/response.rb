class Response < ActiveRecord::Base
  belongs_to :user
  validates :response, presence: true
end
