class BiddingsController < ApplicationController

  def new
    @bidding = Bidding.new
  end

  def index
    @biddings = Bidding.paginate(page: params[:page], per_page: 5)
  end

  def create
    @task = Task.find_or_create_by(bidding_params[:tasks])
    @bidding = @task.biddings.new(bidding_params.except(:tasks))
    if @bidding.save
      redirect_to biddings_path
    else
      render :new
    end
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
