class DashboardController < ApplicationController
  before_action :login_required

  def home
    case
    when current_user.user_type.nil?
      redirect_to role_path
    when current_user.user_type == "taskee" && !current_user.has_taken_quiz
      redirect_to quiz_path
    else
      render :home
    end
  end

  def choose_role
    case
    when current_user.user_type.nil?
      render :choose_role
    when current_user.user_type == "taskee" && current_user.confirmed
      redirect_to dashboard_path
    when current_user.user_type == "taskee" && !current_user.confirmed
      redirect_to quiz_path
    else
      redirect_to dashboard_path
    end
  end

  def set_role
    current_user.update_attribute(:user_type, params[:role])
    if current_user.user_type == "tasker"
      current_user.update_attribute(:has_taken_quiz, true)
      redirect_to dashboard_path
    else
      redirect_to quiz_path
    end
  end

  def quiz
    redirect_to dashboard_path && return if current_user.has_taken_quiz
    if quiz_params[:aced]
      current_user.update_attribute(:has_taken_quiz, true)
      redirect_to dashboard_path
    else
      render :quiz
    end
  end

  def user_profile
    @current_user = current_user
    @profiler = UserProfile.new
    unless profile_params.empty?
      info = @profiler.user_info_hash(profile_params, current_user)
      @current_user.update_columns(info)
      flash[:notice] = "Your profile has been successfully updated!"
    end
  rescue
    flash[:error] = "There was a problem updating your profile.
                    Please try again."
  end

  def profile_view
    @user = User.find(profile_params[:taskee_id])
  end

  def assign_task
  end

  private

  def quiz_params
    params.permit(:aced)
  end

  def profile_params
    params.permit(:user_pix, :phone, :street_address, :city, :state, :gender,
                  :taskee_id, date: [:day, :month, :year])
  end
end
