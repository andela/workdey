class BiddingsController < ApplicationController
  def index
  end

  def create
    @task = Task.find_or_create_by(bidding_params[:tasks])
    @bidding = @task.bidding.new(bidding_params)
    @bidding.task_id = @task.id
    @bidding.save
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
