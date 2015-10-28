class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def login
    user = User.authenticate_user(login_params)
    if user
      session[:loggedin] = true
      redirect_to dashboard_path
    else
      flash[:notice] = "Incorrect login credentials"
    end
  end

  def destroy
    session.clear
    redirect_to root_url
  end

  private

  def login_params
    params.permit(:email, :password, :utf8, :authenticity_token, :commit)
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password)
<<<<<<< HEAD
>>>>>>> 5eefcb8... Add user signup ability
=======
>>>>>>> af0c6a6... Update user model with validations
  end
end
