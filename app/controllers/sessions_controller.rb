class SessionsController < ApplicationController
  before_action :guest_only, only: [:new]

  def new
  end

  def create
    auth = env["omniauth.auth"]
    begin
      user = User.find_by_email(params[:session][:email].downcase)
      login_with_form(user)
    rescue NoMethodError
      user = User.first_or_create_from_oauth(auth)
      log_in(user)
      user_logged_in_view
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private def user_logged_in_view
    if session[:searched_artisan_id]
      redirect_to user_profile_path(
        obfuscate(artisan_id: session[:searched_artisan_id])
      )
    else
      redirect_to dashboard_path
    end
  end

  private def login_with_form(user)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      user_logged_in_view
    else
      flash.now[:invalid] = "Invalid credentials"
      render :new
    end
  end
end
