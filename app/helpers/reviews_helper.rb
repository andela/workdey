module ReviewsHelper
  def review_me
    if current_user.tasker?
      label("taskee")
    else
      label("tasker")
    end
  end

  def label(user_type)
    "Select a #{user_type}"
  end
end
