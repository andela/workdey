class UserDecorator
  attr_reader :user

  def initialize(user)
    @user_decorator = user
  end

  def reviewer_info(comment)
    @reviewer_comment = comment.review
    firstname = comment.reviewer.firstname
    lastname = comment.reviewer.lastname
    @reviewer_name = (firstname + " " + lastname).titleize
    @comment_date = comment.created_at.strftime("%d %b %Y")
  end
end 