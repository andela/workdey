class ServiceRatingsController < ApplicationController
  before_action :set_service_rating, only: [:show, :view_rating_details]

  def index
    @service_ratings = ServiceRating.get_ratings(current_user)
    @average_service_rating = ServiceRating.compute_average_rating(current_user)
  end

  def show
  end

  def view_rating_details
  end

  def new
    service = Service.find(new_service_rating_params[:service_id])
    @service_rating = service.service_ratings.new
  end

  def create
    @service_rating = ServiceRating.new(service_rating_params)
    if @service_rating.save
      redirect_to @service_rating, notice: "Rating submitted succesfully"
    else
      render :new
    end
  end

  private

  def set_service_rating
    @service_rating = ServiceRating.find(params[:id])
  end

  def set_type(user)
    if user.tasker?
      ServiceRating.categories[:tasker_to_artisan]
    else
      ServiceRating.categories[:artisan_to_tasker]
    end
  end

  def new_service_rating_params
    params.permit(:service_id)
  end

  def service_rating_params
    params["service_rating"]["category"] = set_type(current_user)
    params.require(:service_rating).permit(:service_id, :category, :rating,
                                           :private_feedback,
                                           :public_feedback)
  end
end
