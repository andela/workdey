class UserPlansController < ApplicationController

  def index
  end

  def create

  if params[:plan] == "novice"
    amount = 2000
  elsif params[:plan] == "maestro"
    amount = 3000
  end

    customer = Stripe::Customer.create(:email => params[:stripeEmail],
                                       :source  => params[:stripeToken])

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => 'Workdey Stripe customer',
      :currency    => 'usd'
    )
    redirect_to dashboard_path, notice: "Thanks for subscribing. Enjoy"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
