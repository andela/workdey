class Quote < ActiveRecord::Base
  belongs_to :artisan, class_name: "User"
  validates :quoted_value,:artisan_id,:service_id,:status, presence: true

  enum status: [:pending, :accepted, :rejected]
end
