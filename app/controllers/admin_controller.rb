class AdminController < ApplicationController
  before_action :require_admin

  def home
    render :home
  end

  def certify_artisans
    @uncertified_artisans = User.all.where(user_type: 'taskee', certified: false)
    render 'certify_artisans'
  end

  private

  def require_admin
     unless current_user.admin?
       flash[:error] = "You must be an admin to access this resource"
       redirect_to dashboard_path
     end
   end
end
