class PostsController < ApplicationController
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

  # def edit
  #   @post = Post.find(params[:id])
  # end

  # def update
  #   post = Post.find(params[:id])
  #   post.update(post_params)
  # end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :article_text, :status_id, :image ).merge(user_id: current_user.id)
  end
end
