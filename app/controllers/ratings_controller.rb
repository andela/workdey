class RatingsController < ApplicationController
  def new
    @rating = Rating.new
    @user_id = params['user_id']
  end

  def create
    Rating.create(user_id: params["user_id"], comment: params["rating"]["comment"])
    User.find(params['user_id']).update_attribute(:status, :certified)
    redirect_to '/admin/certify_artisans'
  end
end
