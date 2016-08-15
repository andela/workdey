class SkillsetsController < ApplicationController
  before_action :taskee_required

  def index
    @skillsets = current_user.skillsets.select(&:name)
  end

  def create
    @skillset = Skillset.find_or_create_by(
      name: skillset_params[:name]
    ) do |skillset|
      skillset.was_created = true
    end
    unless current_user.skillsets.include? @skillset
      current_user.skillsets << @skillset
    end
    respond_to :js
    @skillset.was_created = false
  end

  def destroy
    @skillset = Skillset.find(params[:skillset_id])
    current_user.skillsets.delete @skillset
    respond_to :js
  end

  private

  def skillset_params
    params.require(:skillset).permit(:name)
  end
end
