class BiddingsController < ApplicationController
  before_action :login_required
  before_action :set_bidding, only: [:edit, :update, :destroy]
  def new
    @bidding = Bidding.new
  end

  def index
    @biddings =
      current_user.biddings.paginate(page: params[:page], per_page: 5)
  end

  def edit
    render :new
  end

  def create
    @bidding = current_user.biddings.new(bidding_params)
    if @bidding.save
      redirect_to biddings_path
    else
      render :new
    end
  end

  def update
    if @bidding.update(bidding_params)
      flash[:success] = "Successfully updated"
      redirect_to biddings_path
    else
      render :new
    end
  end

  def destroy
    @bidding.destroy
    flash[:success] = "Successfully deleted"
    redirect_to biddings_path
  end

  private

  def set_bidding
    @bidding = Bidding.find(params[:id])
  end

  def bidding_params
    params.require(:bidding).permit(
      :description,
      :price_range,
      :name
    )
  end
end
