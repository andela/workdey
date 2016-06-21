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
end
