class TaskManagementsController < ApplicationController
  before_action :login_required, :show_notification_count,
                only: [:index, :show, :review_and_rate]

  def index
    @tasks = current_user.tasks_created if current_user
  end

  def show
  end

  def update
    id = params[:task_id]
    if TaskManagement.find(id).update_attribute(:status, "done")
      if review_and_rate(params)
        flash[:notice] = "Task is completed and your review has been recorded."
      else
        flash[:notice] = "Task is completed."
      end
    else
      flash[:alert] = "Operation failed."
    end
    redirect_to dashboard_path
  end

  private

  def review_and_rate(params)
    review = Review.new
    if params[:user_id] && current_user.id
      review.rating = params[:rating] if params[:rating]
      review.reviewer_id = current_user.id
      review.user_id = params[:user_id]
      review.review = params[:comment] if params[:comment]
      return "success" if review.save
    end
  end
end
