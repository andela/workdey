module ReviewsHelper
  def reviewee(user)
    if user.tasker?
      label("taskee")
    else
      label("tasker")
    end
  end

  def label(user_type)
    "Select a #{user_type}"
  end
end
