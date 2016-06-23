class ReviewDecorator < Draper::Decorator
  delegate_all

  def reviewer_name(current_user)
    if reviewer.id == current_user.id
      "You"
    else
      reviewer.firstname_and_lastname
    end
  end

  def reviewee_name(current_user)
    if reviewee.id == current_user.id
      "You"
    else
      reviewee.firstname_and_lastname
    end
  end

  def respond
    if response
      response
    else
      "There is no response to this review yet"
    end
  end
end
