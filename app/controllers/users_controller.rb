class UsersController < ApplicationController

  def index
    @posts = Post.all.order(created_at: :desc)
    current
  end

  private
  
  def current
    @post_user = Post.exists?(user_id: current_user.id) if user_signed_in?
  end
end
