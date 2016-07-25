# frozen_string_literal: true
class ChargesController < ApplicationController
  def new
  end

  def create
    @amount = params[:amount]
    @task = TaskManagement.find(params[:task_id])
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Task payment charge",
      currency: "usd"
    )
    @task.update_attribute(:paid, true)
    notify("taskee", @task.taskee_id)
    redirect_to dashboard_path, notice: "You have been charged successfully"\
      " and your taskee has been notified"
  rescue Stripe::CardError
    redirect_to dashboard_path, danger: "There was a problem with your card"\
      "\nTry and enter valid card details"
  end
end
