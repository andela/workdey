class ReviewsController < ApplicationController
  before_action :login_required
  def index
    @reviews = ReviewsDecorator.new current_user.reviews
    @feedbacks = ReviewsDecorator.new current_user.feedbacks
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.reviewer_id = current_user.id
    if @review.save
      flash[:success] = "Your review has been successfully submitted"
      redirect_to dashbooard_path
    else
      flash.now[:errors] = "There were errors while trying to review"
      render :new
    end
  end

  private

  def review_params
    params.require(review).permit(
      :rating, :review, :reviewee_id, :task_management_id
    )
  end
end
