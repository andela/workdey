class UsersController < ApplicationController
  def new
     render "create"
  end

  def create
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
  end
end
