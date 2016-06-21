class ReviewCommentsController < ApplicationController
  before_action :login_required
  def create
    @review_comment = ReviewComment.new(review_comment_params)
    @review_comment.user_id = current_user.id
    if @review_comment.save
      render :layout => false
    else
      #Do another thing
    end
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:review_id, :body)
  end
end
