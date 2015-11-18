class DashboardController < ApplicationController
  before_filter :login_required

  def home
    if logged_in? && current_user.user_type.nil?
      redirect_to role_path
    end
  end

  def choose_role
  end

  def set_role
    current_user.update_attribute(:user_type, params[:role])
    redirect_to dashboard_path
  end
end
