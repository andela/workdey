class Users::ResponsesController < ApplicationController

  def new
    @response = Response.new
    @questions = Question.all
  end

  def create
    @questions = Question.all
    @response = current_user.responses.create(response_params)
    if @response.save
      current_user.update_attribute(:has_taken_quiz, true)
      redirect_to users_response_path(@response.id)
    else
      render 'new'
    end
  end

  def show
    @questions = Question.all
    @response = current_user.latest_response
  end

  private

  def response_params
    keys = Question.all.map do |q|
      if q.options.empty?
        q.question
      else
        { q.question => [] }
      end
    end
    { "response" => params.require(:response).permit(keys) }
  end
end
