class PostsController < ApplicationController
  def index
    @posts = Post.order("created_at DESC")
  end

  private

  def post_params
    params.require(:post).permit(title,article_text,status_id)
  end
end
