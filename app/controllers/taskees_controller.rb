class TaskeesController < ApplicationController
  before_action :login_required
  def index
    @taskees = User.taskees.includes(:skillsets).paginate(
      page: params[:page],
      per_page: 10
    )
  end
end
