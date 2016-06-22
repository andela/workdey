class ReviewDecorator < Draper::Decorator
  delegate_all

  def you_or_reviewer(current_user)
    if reviewer.id == current_user.id
      "You"
    else
      reviewer.firstname_and_lastname
    end
  end

  def you_or_reviewee(current_user)
    if reviewee.id == current_user.id
      "You"
    else
      reviewee.firstname_and_lastname
    end
  end
end
