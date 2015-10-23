class User < ActiveRecord::Base
  ALLOWED = /\A[a-zA-Z]+\z/
  has_secure_password

  validates :firstname, presence: true, length: {maximum: 50, minimum: 2}, format: {with: ALLOWED}
  validates :lastname, presence: true, length: {maximum: 50, minimum: 2}, format: {with: ALLOWED}
  validates :email, presence: true, uniqueness: true

  def self.authenticate_user(login_params)
    find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
  end
end
