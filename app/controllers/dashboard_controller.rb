class DashboardController < ApplicationController
  def home
    redirect_to root_url unless logged_in?

    if logged_in? && current_user.user_type.nil?
      redirect_to role_path
    end
  end

  def choose_role
    #require "pry"; binding.pry
    redirect_to dashboard_path unless current_user.user_type.nil?
  end
end
