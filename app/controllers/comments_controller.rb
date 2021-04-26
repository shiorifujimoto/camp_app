class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]
  before_action :correct_user, only: [:destroy]
  
  def create
    comment = Comment.new(comment_params)
    if comment.valid?
      comment.save
      redirect_to post_path(comment.post.id), notice: 'コメントを投稿しました'
    else
      redirect_to post_path(comment.post.id), flash: { error: comment.errors.full_messages }
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def correct_user
    redirect_to post_path(params[:post_id]) unless current_user.id == @comment.user_id
  end
end