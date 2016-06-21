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

  def taskee_required
    redirect_to root_path unless current_user.taskee?
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
    @count = Notification.unseen(current_user).count if current_user
  end

  def pad_date(date_str)
    date_num = date_str.split(" ").detect { |v| v.match(/[0-9]/) }[-1].to_i
    date_str << pad_with(date_num)
  end

  def pad_with(date_num)
    return "st" if date_num == 1
    return "nd" if date_num == 2
    return "rd" if date_num == 3
    "th"
  end

  def format_for_view(start_time, end_time)
    start_time = (start_time + 3600).strftime("%l%P").strip
    end_time = (end_time + 3600).strftime("%l%P").strip
    time_range = "#{start_time} - #{end_time}"
    "#{day_period(time_range)} (#{time_range})"
  end

  def day_period(time_range)
    return "Anytime" if time_range == "8am - 8pm"
    return "Morning" if time_range == "8am - 12pm"
    return "Afternoon" if time_range == "12pm - 4pm"
    "Evening" if time_range == "4pm - 8pm"
  end

end
