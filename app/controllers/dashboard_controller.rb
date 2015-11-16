class DashboardController < ApplicationController
  def home
    redirect_to root_url unless logged_in?
  end
end
