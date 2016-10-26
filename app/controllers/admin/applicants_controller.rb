class Admin::ApplicantsController < ApplicationController
  before_action :login_required
  before_action :require_admin
  before_action :set_applicant, only: [:edit, :update]

  def index
    @applicants = Admin.get_applicants
  end

  def edit
    @questions = Question.all
    @response = @applicant.latest_response
  end

  def update
    @applicant.update_attributes(status: applicant_params[:status].to_i,
                                 reason: applicant_params[:reason])
    redirect_to(admin_applicants_path)
  end

  private

  def set_applicant
    @applicant = User.find(params[:id])
  end

  def applicant_params
    params.require(:user).permit(:status, :reason)
  end
end
