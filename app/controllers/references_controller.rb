class ReferencesController < ApplicationController
  before_action :set_reference, only: [:show]

  def index
  end

  def show
  end

  def new
    @reference = current_user.references.new
  end

  def create
    @reference = current_user.references.new(reference_params)
    if @reference.save
      ReferenceMailer.reference_email(@reference).deliver_later
      flash[:success] = "Email will be sent to #{@reference.email}"
      redirect_to @reference
    else
      flash[:danger] = "Error, please try again."
      render :new
    end
  end

  private

  def set_reference
    @reference = Reference.find(params[:id])
  end

  def reference_params
    params.require(:reference).permit(
      :firstname,
      :lastname,
      :email,
      :relationship
    )
  end
end
