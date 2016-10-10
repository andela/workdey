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
    @applicant.update_attributes(status: applicant_params[:status].to_i,
                                 reason: applicant_params[:reason])
    redirect_to(admin_applicants_path)
  end

  def check_admin
    redirect_to dashboard_path unless current_user.admin?
  end

  private

  def set_applicant
    @applicant = User.find(params[:id])
  end

  def applicant_params
    params.require(:user).permit(:status, :reason)
  end
end
