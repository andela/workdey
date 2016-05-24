class BiddingsController < ApplicationController

  def new
    @bidding = Bidding.new
  end

  def index
    @biddings = current_user.biddings.paginate(page: params[:page], per_page: 5)
  end

  def edit
    @bidding = Bidding.find(params[:id])
    render :new
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

  def update
    @bidding = Bidding.find(params[:id])
    if @bidding.update(bidding_params.except(:tasks))
      flash[:success] = "Successfully updated"
      redirect_to biddings_path
    else
      render :new
    end
  end

  def destroy
    @bidding = Bidding.find(params[:id])
    @bidding.destroy
    flash[:success] = "Successfully deleted"
    redirect_to biddings_path
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
