class QuotesController < ApplicationController
  def create
    @quote = Quote.new(quote_params)
    Notification.create(tasker_quote_notification_params)
    head :ok if @quote.save
  end

  private

  def quote_params
    {
      artisan_id: current_user.id,
      service_id: params["service_id"],
      quoted_value: params["quoted_value"]
    }
  end

  def tasker_quote_notification_params
    {
      message: "An artisan has been assigned to your task",
      sender_id: current_user.id,
      receiver_id: tasker_id,
      notifiable_type: "Quote",
      notifiable_id: params["service_id"]
    }
  end

  def tasker_id
    Service.find_by(id: params["service_id"]).tasker_id
  end
end
