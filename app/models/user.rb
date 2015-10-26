class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase }

  ALLOWED = /\A[a-zA-Z]+\z/
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\.]+[\w+]\.[a-z]+\z/i

  has_secure_password

  validates :firstname, presence: true, length: {maximum: 50, minimum: 2}, format: {with: ALLOWED}
  validates :lastname, presence: true, length: {maximum: 50, minimum: 2}, format: {with: ALLOWED}
  validates :email, presence: true, length: {maximum: 255}, uniqueness: {case_sensitive: false}, format: {with: VALID_EMAIL}
  validates :password, presence: true, length: {minimum: 8}

  def self.authenticate_user(login_params)
    find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
  end
end
