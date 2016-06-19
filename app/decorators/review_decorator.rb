class ReviewDecorator < Draper::Decorator
  delegate_all

  def type_of_review(id, name)
    if id == current_user.id
      "You"
    else
      name
    end
  end
end
