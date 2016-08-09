class TaskeeSkillsetsController < ApplicationController
  before_action :taskee_required

  def index
    @skillsets = Skillset.all
    @user_skillset = current_user.skillset_ids
  end

  def update
    return_data = if params["skills"].blank?
                    { success: false, message: Message.choose_skill }
                  else
                    current_user.taskee_skillsets.destroy_all
                    params["skills"].each do |id|
                      current_user.taskee_skillsets.create(
                        skillset_id: id.to_i
                      )
                    end
                    {
                      success: true,
                      message: Message.update_success("Skills")
                    }
                  end
    render json: return_data
  end
end
