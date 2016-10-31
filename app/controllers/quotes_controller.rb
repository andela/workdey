class QuotesController < ApplicationController
  def create
    @quote = Quote.new(quote_params)
    head :ok if @quote.save
  end

  def quote_params
    {
      artisan_id: current_user.id,
      service_id: params['service_id'],
      quoted_value: params['quoted_value']
    }
  end
end
