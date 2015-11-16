class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
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
