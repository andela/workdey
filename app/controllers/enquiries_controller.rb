class EnquiriesController < ApplicationController
  before_action :login_required

  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.save
      notify_admin
    else
      flash[:error] = @enquiry.errors.full_messages.to_sentence
    end
      redirect_to dashboard_path
  end

  private

  def notify_admin
    admins = User.admins
    admins.each do |admin|
      Notification.create(message: enquiry_params[:question],
      sender_id: current_user.id, receiver_id: admin.id,
      notifiable: @enquiry)
    end
  end

  def enquiry_params
    params.require(:enquiry).permit(:question, :firstname, :email, :user_id,
                                    :response)
  end

  def set_enquiry
    @enquiry = Enquiry.find(params[:id])
  end
end
