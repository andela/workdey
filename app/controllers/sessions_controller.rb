class SessionsController < ApplicationController
  before_filter :guest_only, only: [:new]

  def new
  end

  def create
    auth = env["omniauth.auth"]
    begin
      user = User.find_by_email(params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in(user)
        redirect_to dashboard_path
      else
        flash.now[:invalid] = "Invalid credentials"
        render :new
      end
    rescue NoMethodError
      user = User.first_or_create_from_oauth(auth)
      log_in(user)
      redirect_to dashboard_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
