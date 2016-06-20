class SkillsetsController < ApplicationController
  before_action :taskee_required, except: :search_skillsets

  def index
    @skillsets = current_user.skillsets.select(&:name)
  end

  def create
    @skillset = Skillset.find_or_create_by(
      user_id: current_user.id,
      name: skillset_params[:name]
    ) { |skillset| skillset.was_created = true }
    respond_to :js
    @skillset.was_created = false
  end

  def destroy
    @skillset = current_user.skillsets.detect do |skillset|
      skillset.task_id == params[:task_id].to_i
    end.destroy
    respond_to :js
  end

  def search_skillsets
    query = params[:query]
    skillsets = Skillset.where("LOWER(name) Like ?", "%#{query.downcase}%")
    respond_to do |format|
      format.json { render json: skillsets }
    end
  end

  private

  def skillset_params
    params.require(:skillset).permit(:name)
  end
end
