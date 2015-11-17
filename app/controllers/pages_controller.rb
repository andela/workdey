class PagesController < ApplicationController
  def index
    redirect_to dashboard_path if logged_in?
  end

  def about
  end

  def contact
  end

  def terms
  end

  def become_a_taskee
  end
end
