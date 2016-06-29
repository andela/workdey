class ReviewsController < ApplicationController
  before_action :login_required
  def index
    @reviews = ReviewsDecorator.new current_user.reviews
    @feedbacks = ReviewsDecorator.new current_user.feedbacks
  end

  def show
    review = Review.find(params[:id])
    @review = review.decorate
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.reviewer_id = current_user.id
    if @review.save
      flash[:success] = "Your review has been successfully submitted"
      redirect_to dashboard_path
    else
      flash.now[:errors] = "There were errors while trying to review"
      params[:task] = TaskManagement.find(params[:task_management_id]).task_desc
      params[:tasker] = User.find(params[:reviewee_id]).firstname_and_lastname
      params[:taskee] = User.find(params[:reviewee_id]).firstname_and_lastname
      render "new"
    end
  end

  def update
    @review = Review.find(params[:id])
    @review.response = params[:response]
    if @review.save
      flash[:success] = "Your response has been recorded"
      redirect_to reviews_path
    else
      flash[:error] = "An error occured"
      @review = @review.decorate
      render "show"
    end
  end

  private

  def review_params
    params.permit(
      "rating", "body", "reviewee_id", "task_management_id"
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
