class ReviewCommentsDecorator < Draper::CollectionDecorator
  def render_comments
    if empty?
      "No comments to show yet, You may add a comment"
    else
      h.render partial: 'comment', collection: self
    end
  end
end
