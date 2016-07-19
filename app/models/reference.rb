class Reference < ActiveRecord::Base
  belongs_to :taskee, class_name: "User"

  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\.]+[\w+]\.[a-z]+\z/i

  validates_presence_of :firstname, :lastname, :relationship
  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL }
end
