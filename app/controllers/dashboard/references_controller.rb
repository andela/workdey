module Dashboard
  class ReferencesController < ApplicationController
    before_action :login_required

    def index
      @references = current_user.references
    end

    def new
      @reference = current_user.references.new
      @taskee_skillsets = current_user.skillsets
    end

    def create
      @reference = current_user.references.new(formatted_reference_params)
      @reference.confirmation_token = SecureRandom.urlsafe_base64.to_s
      if @reference.save
        url =
          "#{new_dashboard_endorsement_url}?t=#{@reference.confirmation_token}"
        ReferenceMailer.reference_email(@reference, url).deliver_later
        flash[:notice] = "An email will be sent to #{@reference.email}"
      else
        flash[:notice] = "Error, please try again."
      end
      redirect_to new_dashboard_reference_path
    end

    private

    def set_reference
      @reference = Reference.find(params[:id])
    end

    def formatted_reference_params
      params_ = reference_params.merge(skillsets: {})
      params_[:skillsets][:skills] = []
      reference_params[:skillsets].each do |skillset|
        if skillset.present?
          params_[:skillsets][:skills] << skillset
        end
      end
      params_
    end

    def reference_params
      params.require(:reference).permit(
        :firstname,
        :lastname,
        :email,
        :relationship,
        skillsets: []
      )
    end
  end
end
