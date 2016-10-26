class Admin::RatingsController < ApplicationController
  before_action :require_admin
  def new
    @rating = Rating.new
    @user_id = params["user_id"]
    @vetting_record = VettingRecord.find_by_user_id(@user_id)
  end

  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      User.find(params["user_id"]).update_attribute(:status, :certified)
      redirect_to certify_artisans_admin_ratings_path
    else
      redirect_to :back, flash: { errors: @rating.errors.messages }
    end
  end

  def certify_artisans
    @uncertified_artisans = User.all.select(&:accepted?)
    render "certify_artisans"
  end

  private

  def rating_params
    {
      user_id: params["user_id"],
      comment: params["rating"]["comment"],
      rating: params["rating"]["rating"]
    }
  end
end
