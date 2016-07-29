class AccountActivationsController < ApplicationController
  def confirm_email
    user = User.find_by_email(confirmation_params[:email])
    user ? User.confirm_user(confirmation_params[:id]) : false
    flash[:mail] = "Your account has been activated"
    redirect_to dashboard_path
  end

  def resend_activation_mail
    UserMailer.account_activation(current_user).deliver_now
    flash[:mail] = "Confirmation mail has been sent to your account, " \
                   "please check your mail"
    redirect_to dashboard_path
  end

  private

  def confirmation_params
    params.permit(:email, :id)
  end
end
