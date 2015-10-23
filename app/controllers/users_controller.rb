class UsersController < ApplicationController
  def new
     render "create"
  end

  def temp
    @user = User.new
  end

  def create
<<<<<<< HEAD
    user = User.authenticate_user(login_params)
    if user
      session[:loggedin] = true
      redirect_to dashboard_path
    else
      flash[:notice] = "Incorrect login credentials"
    end
  end

  def destroy
    session.clear()
    redirect_to root_url
  end

private

  def login_params
    params.permit(:email, :password, :utf8, :authenticity_token, :commit)
=======
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
>>>>>>> 5eefcb86e25c30923b74e0acb3f20ed662b15fef
  end
end
