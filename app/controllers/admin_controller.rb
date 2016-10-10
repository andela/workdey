class AdminController < ApplicationController
  before_action :require_admin

  def home
    render :home
  end

  def certify_artisans
    @uncertified_artisans = User.all.select { |a_user| a_user.accepted? }
    render 'certify_artisans'
  end
end
