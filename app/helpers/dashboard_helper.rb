module DashboardHelper
  def reviewer_info(comment)
    firstname = comment.reviewer.firstname
    lastname = comment.reviewer.lastname
    @reviewer_name = (firstname + " " + lastname).titleize
    @comment_date = comment.created_at.strftime("%d %b %Y")
  end

  def review_someone
    if current_user.tasker?
      "Review a taskee"
    else
      "Review a tasker"
    end
  end
end
