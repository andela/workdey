class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path if logged_in?
  end

  def create
    auth = env["omniauth.auth"]
    begin
      user = User.find_by_email(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in(user)
        redirect_to role_path and return
      else
        render :new
      end
    rescue NoMethodError
      user = User.first_or_create_from_oauth(auth)
      log_in(user)
      redirect_to role_path and return
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
