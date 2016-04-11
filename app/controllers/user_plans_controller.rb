class UserPlansController < ApplicationController

  def index
  end

  def create

  if params[:plan] == "novice"
    amount = 2000
    description = "Workdey novice user"
  elsif params[:plan] == "maestro"
    amount = 3000
    description = "Workdey maestro user"
  end

    customer = Stripe::Customer.create(:email => params[:stripeEmail],
                                       :source  => params[:stripeToken])

    Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => description,
      :currency    => 'usd'
    )
    redirect_to dashboard_path, notice: "Thanks for subscribing. Enjoy"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
