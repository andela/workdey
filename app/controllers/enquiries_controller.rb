class EnquiriesController < ApplicationController
  before_action :login_required
  before_action :require_admin, only: [:edit, :update]
  before_action :set_enquiry, only: [:edit, :update]

  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.save
      notify_admin
    else
      flash[:error] = @enquiry.errors.full_messages.to_sentence
      redirect_to root_url
    end
  end

  def show
  end

  def edit
  end

  def update
    if @enquiry.update(enquiry_params)
      notify_user
      redirect_to biddings_path
    else
      flash[:error] = @enquiry.errors.full_messages.to_sentence
    end
  end

  private

  def notify_admin
    admin = User.find_by(user_type: "admin")
    Notification.create(message: enquiry_params[:question],
    sender_id: current_user.id, receiver_id: admin.id,
    notifiable_id: @enquiry.id,
    notifiable_type: "Enquiry")
    redirect_to dashboard_path
  end

  def notify_user
    user = User.find_by(id: @enquiry.user_id)
    Notification.create(message: enquiry_params[:response],
    sender_id: current_user.id, receiver_id: user.id,
    notifiable_id: @enquiry.id,
    notifiable_type: "Enquiry")
    redirect_to dashboard_path
  end

  def enquiry_params
    params.require(:enquiry).permit(:question, :firstname, :email, :user_id,
                                    :response)
  end

  def set_enquiry
    @enquiry = Enquiry.find(params[:id])
  end
end
