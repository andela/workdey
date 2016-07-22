# frozen_string_literal: true
class SkillsetsController < ApplicationController
  before_action :taskee_required

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
      skillset.id == params[:skillset_id].to_i
    end.destroy
    respond_to :js
  end

  private

  def skillset_params
    params.require(:skillset).permit(:name)
  end
end
