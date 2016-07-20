class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show]
  before_action :set_endorsement, only: [:new_endorsement, :create_endorsement]

  def index
    @references = current_user.references
  end

  def show
  end

  def new
    @reference = current_user.references.new
    @taskee_skillsets = current_user.skillsets
  end

  def create
    @reference = current_user.references.new(formatted_reference_params)
    @reference.confirmation_token = SecureRandom.urlsafe_base64.to_s
    if @reference.save
      url = "#{new_endorsement_url}?t=#{@reference.confirmation_token}"
      ReferenceMailer.reference_email(@reference, url).deliver_later
      flash[:notice] = "An email will be sent to #{@reference.email}"
    else
      flash[:notice] = "Error, please try again."
    end
    redirect_to new_reference_path
  end

  def new_endorsement
    @taskee = @reference.taskee.firstname
    @taskee_skillsets = @reference.skillsets.keys
  end

  def create_endorsement
    endorsement_params[:references][:skillsets].each.with_index do |skill, i|
      @reference.skillsets[skill] = [
        endorsement_params[:recommendation],
        endorsement_params[:relationship]
      ]
    end
    if @reference.save
      flash[:notice] = "Your recommendation has been sent."
    else
      flash[:notice] = "Oops, something went wrong please try again."
    end
    redirect_to root_path
  end

  private

  def set_reference
    @reference = Reference.find(params[:id])
  end

  def set_endorsement
    @reference = Reference.find_by(confirmation_token: params[:t])
  end

  def formatted_reference_params
    params_ = reference_params.merge(skillsets: {})
    reference_params[:skillsets].each do |skillset|
      if skillset.present?
        params_[:skillsets][skillset.to_sym] = {}
      end
    end
    params_
  end

  def endorsement_params
    params.permit(
      :relationship,
      :recommendation,
      references: { skillsets: [] }
    )
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
