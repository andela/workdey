class Users::ResponsesController < ApplicationController
  before_action :get_questions

  def new
    @response = Response.new
  end

  def create
    @response = current_user.responses.new(strip_all(response_params))
    if @response.save
      response_params["response"][Question.first.question].each do |skillset|
        add_skillset(skillset)
      end
      current_user.update_attribute(:has_taken_questionnaire, true)
      redirect_to users_response_path(@response.id)
    else
      render "new"
    end
  end

  def show
    @response = current_user.latest_response
  end

  private

  def add_skillset(skillset)
    skill = Skillset.find_or_create_by(name: skillset)
    ArtisanSkillset.create(
      skillset_id: skill.id,
      artisan_id: current_user.id
    )
  end

  def get_questions
    @questions = Question.ranked
  end

  def strip_all(response_params)
    response_params["response"].map do |key, _value|
      if response_params["response"][key].is_a?(Array)
        response_params["response"][key].map(&:strip!)
      else
        response_params["response"][key].strip!
      end
    end
    response_params
  end

  def response_params
    keys = Question.ranked.map do |q|
      if q.options.empty? || !q.can_select_multiple
        q.question
      else
        { q.question => [] }
      end
    end
    { "response" => params.require(:response).permit(keys) }
  end
end
