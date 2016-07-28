class UserPlansController < ApplicationController
  before_action :check_amount, only: :create

  def index
  end

  def create
    customer = Stripe::Customer.create(email: params[:stripeEmail],
                                       source: params[:stripeToken])

    Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: @description,
      currency: "usd"
    )
    UserPlan.subscribe_user(current_user.id, params[:plan])
    redirect_to dashboard_path, notice: "Thanks for subscribing. Enjoy"
  rescue Stripe::CardError => e
    redirect_to user_plans_url, notice: e.message
  end

  private

  def check_amount
    if params[:plan] == "medial"
      @amount = 2000
      @description = "Workdey medial user"
    elsif params[:plan] == "maestro"
      @amount = 3000
      @description = "Workdey maestro user"
    end
  end
end
