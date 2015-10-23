class User < ActiveRecord::Base
  ALLOWED = /\A[a-zA-Z]+\z/
  has_secure_password
<<<<<<< HEAD
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true

  def self.authenticate_user(login_params)
    find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
  end
=======
  validates :firstname, presence: true, length: {maximum: 50, minimum: 2}, format: {with: ALLOWED}
  validates :lastname, presence: true, length: {maximum: 50, minimum: 2}, format: {with: ALLOWED}
  validates :email, presence: true, uniqueness: true
>>>>>>> 5eefcb86e25c30923b74e0acb3f20ed662b15fef
end
