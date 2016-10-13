class AdminController < ApplicationController
  before_action :require_admin

  def home
    render :home
  end

  def certify_artisans
    @uncertified_artisans = User.all.select(&:accepted?)
    render "certify_artisans"
  end
end
