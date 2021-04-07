class UsersController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
    @post_user = Post.exists?(user_id: current_user.id)
 
  end
end
