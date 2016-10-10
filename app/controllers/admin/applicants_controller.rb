class Admin::ApplicantsController < ApplicationController
  before_action :login_required
  before_action :check_admin
  before_action :set_applicant, only: [:edit, :update]

  def index
    @applicants = Admin.get_applicants
  end

  def edit
  end

  def update
    @applicant.update_attribute(:status, params[:status].to_i)
    redirect_to(admin_applicants_path)
  end

  def check_admin
    redirect_to dashboard_path unless current_user.admin?
  end

  private

  def set_applicant
    @applicant = User.find(params[:id])
  end
end
