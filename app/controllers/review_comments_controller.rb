class ReviewCommentsController < ApplicationController
  before_action :login_required
  def create
    @review_comment = ReviewComment.new(review_comment_params)
    @review_comment.review_id = params[:review_id]
    @review_comment.user_id = current_user.id
    if @review_comment.save
      render :create
    else
      render :error
    end
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:body)
  end
end
