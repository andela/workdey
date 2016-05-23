class BiddingsController < ApplicationController
  def index
  end

  def create
    @task = Task.find_or_create_by(bidding_params[:tasks])
    @bidding = @task.biddings.new(bidding_params.except(:tasks))
    # @bidding.save
    respond_to :js
  end

  private

  def bidding_params
    params.require(:bidding).permit(
      :description,
      :price_range,
      tasks: [:name]
    )
  end
end
