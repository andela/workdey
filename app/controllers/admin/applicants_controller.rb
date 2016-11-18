class Admin::ApplicantsController < ApplicationController
  before_action :login_required
  before_action :check_admin
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

  def check_admin
    redirect_to dashboard_path unless current_user.admin?
  end

  def regret_email
    rejected_users = User.artisans.rejected
    body = params[:body]
    rejected_users.each do |user|  
    RegretMailer.regret_email(user, body).deliver_now
    end
    head :no_content
  end

  private

  def set_applicant
    @applicant = User.find(params[:id])
  end

  def applicant_params
    params.require(:user).permit(:status, :reason)
  end
end
