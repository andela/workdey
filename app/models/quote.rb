class Quote < ActiveRecord::Base
  validates :artisan_id, presence: true
  validates :service_id, presence: true
  validates :quoted_value, presence: true

  belongs_to :service
  belongs_to :artisan, class_name: User

  enum status: [:pending, :accepted, :rejected]
end
