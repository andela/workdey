class User < ActiveRecord::Base
  has_many :skillsets
  has_many :tasks, through: :skillsets
  before_save { self.email = email.downcase }

  ALLOWED = /\A[a-zA-Z]+\z/
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\.]+[\w+]\.[a-z]+\z/i

  has_secure_password

  validates :firstname,
            presence: true,
            length: { in: 2..50 },
            format: { with: ALLOWED }

  validates :lastname,
            presence: true,
            length: { in: 2..50 },
            format: { with: ALLOWED }

  validates :email,
            presence: true,
            length: { maximum: 255 },
            uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL }

  validates :password,
            presence: true,
            length: { minimum: 8 }

  def self.first_or_create_from_oauth(auth)
    where(email: auth.info.email).first_or_create do |u|
      u.provider = auth.provider
      u.oauth_id = auth.uid
      u.firstname = auth.info.name.split(" ").first
      u.lastname = auth.info.name.split(" ").last
      u.email = auth.info.email
      u.password = SecureRandom.urlsafe_base64
    end
  end
end
