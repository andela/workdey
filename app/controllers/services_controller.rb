class ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]

  def index
    @services = Service.pending_requests(current_user)
  end

  def show
  end

  def new
    @service = Service.new
    @skillsets = Skillset.all
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to service_path(@service), notice:
                    "Service request was successfully created."
    else
      redirect_to new_service_path, notice: @service.errors.full_messages
    end
  end

  private

  def set_service
    @service = Service.find(params[:id])
  end

  def set_takser
    params["service"]["tasker_id"] = current_user.id
  end

  def set_duration
    params["service"]["duration"] = (Date.parse(params["service"]["end_date"]) -
                            Date.parse(params["service"]["start_date"])).to_i
  end

  def service_params
    set_takser
    set_duration
    params.require(:service).permit(:tasker_id, :title, :skillset_id,
                                    :description, :start_date, :end_date,
                                    :duration)
  end
end
