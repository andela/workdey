class Users::ResponsesController < ApplicationController
  before_action :get_questions

  def new
    @response = Response.new
  end

  def create
    @response = current_user.responses.create(response_params)
    if @response.save
      current_user.update_attribute(:has_taken_quiz, true)
      redirect_to users_response_path(@response.id)
    else
      redirect_to new_users_response_path, flash: { errors: @response.errors}
    end
  end

  def show
    @response = current_user.latest_response
  end

  private

  def get_questions
    @questions = Question.all
  end

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
