class AdminController < ApplicationController
  before_action :login_required
  before_action :check_admin

  def view_applications
    @applicants = Admin.get_applicants
  end

  def review_applicant
    @applicant = User.find(params[:id])
    @responses = Response.where("user_id = ?", params[:id])
  end

  def update_applicant
    @applicant = User.find(params[:user_id])
    @applicant.update_attribute(:status, params[:review_appl].to_i)
    redirect_to(applications_path)
  end

  def check_admin
    unless current_user.admin?
      redirect_to dashboard_path
    end
  end
end
