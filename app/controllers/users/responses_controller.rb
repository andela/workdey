class Users::ResponsesController < ApplicationController
  before_action :get_questions
  before_action :enquiry

  def new
    @response = Response.new
  end

  def create
    @response = current_user.responses.new(response_params)
    if @response.save
      response_params["response"][Question.first.question].each do |s|
        add_skillset(s)
      end
      current_user.update_attribute(:has_taken_questionnaire, true)
      redirect_to users_response_path(@response.id)
    else
      redirect_to new_users_response_path, flash: { errors: @response.errors}
    end
  end

  def show
    @response = current_user.latest_response
  end

  private

  def add_skillset(skillset)
    skill = Skillset.find_or_create_by(name: skillset)
    ArtisanSkillset.create(skillset_id: skill.id,
        artisan_id: current_user.id)
  end

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
