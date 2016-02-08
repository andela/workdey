class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :obfuscate

  include SessionsHelper

  def login_required
    redirect_to root_path unless logged_in?
  end

  def guest_only
    redirect_to dashboard_path if logged_in?
  end

  def obfuscate(hash)
    require "base64"

    hash.each do |k, v|
      @encoded_key = Base64.encode64(k.to_s)
      @encoded_value = Base64.encode64(v.to_s)
    end

    @encoded_key.delete!("\n")
    @encoded_value.delete!("\n")

    { @encoded_key => @encoded_value }
  end

  def deobfuscate(hash)
    require "base64"

    hash.each do |k, v|
      @decoded_key = Base64.decode64(k.to_s)
      @decoded_value = Base64.decode64(v.to_s)
    end

    @decoded_key.delete!("\n")
    @decoded_value.delete!("\n")

    { @decoded_key => @decoded_value }
  end

  def show_notification_count
    if current_user
      @count = TaskManagement.
               notifications_count(current_user.user_type, current_user.id)
    end
  end

  def notify(user_type, id)
    data = TaskManagement.notifications_count(user_type, id)
    WebsocketRails.users[id].send_message :new_task, data
  end
end
