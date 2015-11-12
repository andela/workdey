class SessionsController < ApplicationController
  def new
    #redirect_to dashboard_path if logged_in?
  end

  def create
    auth = env["omniauth.auth"]
    require "pry"; binding.pry
    #user = User.find_by_email(params[:session][:email].downcase)
    # if user && user.authenticate(params[:session][:password])
    #   log_in(user)
    #   redirect_to dashboard_path
    # else
    #   #flash.now[:alert] = "Oops, seems like you are not a super user. Try again!"
    #   render :new
    # end
  end

  def destroy
    log_out
    #flash_and_redirect(:alert, "You have signed out!", root_path)
  end
end
