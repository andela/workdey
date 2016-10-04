class RatingsController < ApplicationController
  def new
    @rating = Rating.new
    @user_id = params['user_id']
  end

  def create
    require 'pry'; binding.pry
    Rating.create(user_id: params["user_id"], comment: params["rating"]["comment"])
    User.find(params['user_id']).update_attribute(:status, :certified)
    require 'pry'; binding.pry
    redirect_to '/admin/certify_artisans'
  end
end
