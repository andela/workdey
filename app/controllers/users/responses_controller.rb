class Users::ResponsesController < ApplicationController
  layout "questionnaire"

  def new
    @response = Response.new
  end

  def create
    @response = Response.new(response_params)
    if @response.save
    else
      render 'new'
    end
  end

  private

  def response_params
    params.require(:response).permit(:response)
  end
end
