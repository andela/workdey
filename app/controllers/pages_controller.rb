class PagesController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def terms
  end

  def become_a_taskee
  end

  def search
    keyword = params[:searcher]
    @taskees = Task.get_task_doers(keyword)
    # user_address = User.get_user_address #user_email
    # geo_loc = Geokit::Geocoders::GoogleGeocoder.geocode user_address
    render "search_result"
  end

end
