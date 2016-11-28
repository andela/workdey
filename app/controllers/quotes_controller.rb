class QuotesController < ApplicationController
  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      head :ok
      notify_tasker
    end
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
      notifiable_id: @quote.id
    }
  end

  def tasker_id
    Service.find_by(id: params["service_id"]).tasker_id
  end

  def notify_tasker
    Notification.create(tasker_quote_notification_params)
  end
end
