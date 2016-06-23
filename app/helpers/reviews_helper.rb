module ReviewsHelper
  def review_me
    if current_user.tasker?
      user_type("taskee")
    else
      user_type("tasker")
    end
  end

  def user_type(type)
    "Select a #{type}"
  end

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
