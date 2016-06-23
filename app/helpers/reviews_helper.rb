module ReviewsHelper
  def tasker_or_taskee
    if current_user.tasker?
      "taskee"
    else
      "tasker"
    end
  end

  def reviewed? task
    review = Review.find_by(
      reviewer_id: current_user.id,
      task_management_id: task.id
    )
    review ? true : false
  end
end
