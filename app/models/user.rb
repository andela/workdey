class User < ActiveRecord::Base
  has_secure_password
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :email, presence: true

  def self.authenticate_user(login_params)
    find_by(email: login_params[:email]).try(:authenticate, login_params[:password])
  end
end
