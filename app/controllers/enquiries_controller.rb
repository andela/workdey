class EnquiriesController < ApplicationController
  before_action :login_required
  before_action :require_admin, only: [:edit, :update]
  before_action :set_enquiry, only: [:show, :edit, :update]

  def create
    @enquiry = Enquiry.new(enquiry_params)
    if @enquiry.save
      notify_admin
    else
      flash[:error] = @enquiry.errors.full_messages.to_sentence
    end
      redirect_to dashboard_path
  end

  def show
    render json: @enquiry
  end

  def edit
  end

  def update
    if @enquiry.update(enquiry_params)
      notify_user
      @enquiry.update_attribute(:answered, true)
    else
      flash[:error] = @enquiry.errors.full_messages.to_sentence
    end
      redirect_to dashboard_path
  end

  private

  def notify_admin
    admin = User.find_by(user_type: "admin")
    Notification.create(message: enquiry_params[:question],
    sender_id: current_user.id, receiver_id: admin.id,
    notifiable: @enquiry.id)
  end

  def notify_user
    user = User.find_by(id: @enquiry.user_id)
    Notification.create(message: enquiry_params[:response],
    sender_id: current_user.id, receiver_id: user.id,
    notifiable_id: @enquiry.id,
    notifiable_type: "Enquiry")
  end

  def enquiry_params
    params.require(:enquiry).permit(:question, :firstname, :email, :user_id,
                                    :response)
  end

  def set_enquiry
    @enquiry = Enquiry.find(params[:id])
  end
end
