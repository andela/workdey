module Dashboard
  class EndorsementsController < ApplicationController
    before_action :set_endorsement, only: [:new, :create]

    def new
      @taskee = @reference.taskee.firstname
      @taskee_skillsets = JSON.parse(@reference.skillsets["skills"])
    end

    def create
      @reference.skillsets[:endorsement] = [
        endorsement_params[:recommendation],
        endorsement_params[:relationship]
      ]
      @reference.done = true
      if @reference.save
        flash[:notice] = "Your recommendation has been sent."
      else
        flash[:notice] = "Oops, something went wrong please try again."
      end
      redirect_to root_path
    end

    private

    def set_endorsement
      @reference = Reference.find_by(confirmation_token: params[:t])
      if @reference.done
        redirect_to new_dashboard_reference_path,
                    notice: Message.expired_endorsement_token
      end
    end

    def endorsement_params
      params.permit(
        :relationship,
        :recommendation,
        references: { skillsets: [] }
      )
    end
  end
end
