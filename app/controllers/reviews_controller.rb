class ReviewsController < ApplicationController
  before_action :login_required
  def index
    @reviews = ReviewsDecorator.new current_user.reviews
    @feedbacks = ReviewsDecorator.new current_user.feedbacks
  end

  def show
    @review = Review.find(params[:id]).decorate
  end

  def new
    @review = Review.new
    @users = UsersDecorator.new users
  end

  def create
    @review = Review.new(review_params)
    @review.reviewer_id = current_user.id
    if @review.save
      flash[:success] = "Your review has been successfully submitted"
      redirect_to dashboard_path
    else
      flash.now[:errors] = "There were errors while trying to review"
      @users = UsersDecorator.new users
      render "new"
    end
  end

  private

  def review_params
    params.permit(
      :rating, :review, :reviewee_id, :task_management_id
    )
  end

  def users
    if current_user.tasker?
      current_user.taskees
    else
      current_user.taskers
    end
  end
end
