class ChargesController < ApplicationController
  before_action :enquiry

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
    notify_artisan @task
    redirect_to dashboard_path, notice: "You have been charged successfully"\
      " and your artisan has been notified"
  rescue Stripe::CardError
    redirect_to dashboard_path, danger: "There was a problem with your card"\
      "\nTry and enter valid card details"
  rescue Stripe::InvalidRequestError
    redirect_to dashboard_path, notice: "An error occured while authenticating"\
      ".\nYou have to try again"
  end

  def notify_artisan(task)
    tasker = User.find(task.tasker_id).firstname
    Notification.create(
      message: "a new task from #{tasker}",
      sender_id: task.tasker_id,
      receiver_id: task.artisan_id,
      notifiable: task
    ).notify_receiver("new_task")
  end
end
