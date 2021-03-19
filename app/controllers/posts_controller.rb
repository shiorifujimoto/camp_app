class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.create
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    unless @post.update(post_params)
      render :edit
    end
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:title, :article_text, :status_id, :image ).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
