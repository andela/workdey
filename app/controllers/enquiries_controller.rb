class BiddingsController < ApplicationController
  before_action :login_required

  def create
    @enquiry = Enquiry.new(full_params)
    if @enquiry.save
      notify_admin
    else
      flash[:danger] = @enquiry.errors.full_messages.to_sentence
      redirect_to root_url
    end
  end

  private

  def notify_admin


  end
end
