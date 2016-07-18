class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = params[:amount]
    @task =
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Task payment charge',
      :currency    => 'usd'
    )
    @task.update_attribute(:paid, true)
    notify("taskee", @task.taskee_id)
    redirect_to dashboard_path, notice: "You have been charged successfully"\
      "and your taskee has been notified"
  rescue Stripe::CardError => e
    flash[:error] = e.message
    render "task_managements/pay"
  end
end
