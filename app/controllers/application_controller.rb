class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  def login_required
    redirect_to root_path unless logged_in?
  end

  def guest_only
    redirect_to dashboard_path if logged_in?
  end

end