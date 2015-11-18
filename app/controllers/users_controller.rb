class UsersController < ApplicationController
  before_filter :guest_only, only: [:new]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      UserMailer.account_activation(@user).deliver_now
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password)
  end
end
