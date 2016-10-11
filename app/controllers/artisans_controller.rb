class ArtisansController < ApplicationController
  before_action :login_required
  def index
    @artisans = User.artisans.includes(:skillsets).paginate(
      page: params[:page],
      per_page: 10
    )
  end
end
