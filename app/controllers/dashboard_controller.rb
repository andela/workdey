class DashboardController < ApplicationController
  before_action :login_required
  before_action :show_notification_count,
                only: [:home, :user_profile, :profile_view, :choose_role]

  def home
    if current_user.user_type.nil?
      redirect_to role_path
    elsif current_user.user_type == "artisan" &&
      current_user.confirmed && !current_user.has_taken_questionnaire
      redirect_to new_users_response_path
    elsif current_user.admin?
      render :admin_home
    else
      @completion_percentage = calculate_profile_completeness
      render :home
    end
  end

  def choose_role
    if current_user.user_type.nil?
      render :choose_role
    elsif current_user.user_type == "artisan" && current_user.confirmed
      redirect_to dashboard_path
    else
      redirect_to dashboard_path
    end
  end

  def set_role
    if params[:role] == "tasker"
      current_user.update_attribute(:user_type, params[:role])
      current_user.update_attribute(:has_taken_questionnaire, true)
      redirect_to dashboard_path
    else
      @skillsets = Skillset.all
      current_user.update_attribute(:user_type, params[:role])
      redirect_to dashboard_path
    end
  end

  def create_skillset
    if params["skillsets"].blank?
      redirect_to(role_path, notice: Message.choose_skill) && return
    end
    params["skillsets"].each do |skill_id|
      Skillset.find_by!(id: skill_id)
      current_user.artisan_skillsets.create(skillset_id: skill_id)
    end
    current_user.update_attribute(:user_type, "artisan")
    redirect_to quiz_path
  rescue ActiveRecord::RecordNotFound
    redirect_to role_path, notice: Message.try_again
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
    param = deobfuscate(params.except(
                          :controller,
                          :action,
                          :artisan_view
    ))["artisan_id"]
    @user = User.find(param)
  end

  def search_with_map
    @current_user = current_user
    @skillsets = Skillset.all
  end

  def assign_task
    deobfuscate(params.except(:controller, :action))["artisan_id"]
  end

  private

  def profile_params
    params.permit(:user_pix, :phone, :street_address, :city, :state, :gender,
                  :artisan_id, date: [:day, :month, :year])
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
    add_skillset_for_artisan(completed, profile_parameters.count)
  end

  def add_skillset_for_artisan(completed, profile_parameters)
    if current_user.artisan?
      completed += current_user.skillsets.empty? ? 0 : 1.0
      profile_parameters += 1
    end
    ((completed / profile_parameters.to_f) * 100).round
  end
end
