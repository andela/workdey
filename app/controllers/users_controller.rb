class UsersController < ApplicationController
  def new
  end

  def temp
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to dashboard_path
    else
      render "temp"
    end

  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password)
  end
end
