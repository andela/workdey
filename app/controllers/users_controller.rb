class UsersController < ApplicationController
  before_action :guest_only, only: [:new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      UserMailer.account_activation(@user).deliver_now
      redirect_to dashboard_path
    else
      render "new"
    end
  end

  def update_notification_settings
    if notifications_params[:notifications_enabled] == "on"
      current_user.update_attribute(:enable_notifications, true)
    else
      current_user.update_attribute(:enable_notifications, false)
    end
    redirect_to "/dashboard"
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password)
  end

  def notifications_params
    params.permit(:notifications_enabled)
  end
end
