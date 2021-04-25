class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    comment = Comment.new(comment_params)
    if comment.valid?
      comment.save
      redirect_to post_path(comment.post.id), notice: "コメントを投稿しました。"
    else
      redirect_to post_path(comment.post.id), flash: { error: comment.errors.full_messages }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end