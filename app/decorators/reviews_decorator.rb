class ReviewsDecorator < Draper::CollectionDecorator

  def render_reviews(reviews)
    if empty?
      "You have no #{reviews} yet"
    else
      h.render partial: "#{reviews.chop}", collection: self
    end
  end

end
