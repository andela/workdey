# frozen_string_literal: true
class DashboardController < ApplicationController
  before_action :login_required
  before_action :show_notification_count,
                only: [:home, :user_profile, :profile_view, :choose_role, :quiz]

  def home
    if current_user.user_type.nil?
      redirect_to role_path
    elsif current_user.user_type == "taskee" && !current_user.has_taken_quiz
      redirect_to quiz_path
    else
      @completion_percentage = calculate_profile_completeness
      render :home
    end
  end

  def choose_role
    if current_user.user_type.nil?
      render :choose_role
    elsif current_user.user_type == "taskee" && current_user.confirmed
      redirect_to dashboard_path
    elsif current_user.user_type == "taskee" && !current_user.confirmed
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
    redirect_to(dashboard_path) && return if current_user.has_taken_quiz
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
    param = deobfuscate(params.except(:controller, :action))["taskee_id"]
    @user = User.find(param)
  end

  def search_with_map
    @current_user = current_user
    @users = User.all
  end

  def assign_task
    deobfuscate(params.except(:controller, :action))["taskee_id"]
  end

  private

  def quiz_params
    params.permit(:aced)
  end

  def profile_params
    params.permit(:user_pix, :phone, :street_address, :city, :state, :gender,
                  :taskee_id, date: [:day, :month, :year])
  end

  def location_params
    params.permit(:longitude, :latitude)
  end

  def calculate_profile_completeness
    all_user_attr = current_user.attributes
    profile_parameters = all_user_attr.keep_if do |key, _value|
      !DEFAULT_ATTR.include? key
    end
    completed = profile_parameters.values.count { |parameter| parameter }.to_f
    add_skillset_for_taskee(completed, profile_parameters.count)
  end

  def add_skillset_for_taskee(completed, profile_parameters)
    if current_user.taskee?
      completed += current_user.skillsets.empty? ? 0 : 1.0
      profile_parameters += 1
    end
    ((completed / profile_parameters.to_f) * 100).round
  end
end
