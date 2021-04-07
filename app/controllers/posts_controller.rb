class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      return redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      set_tag
      render :edit
    end
  end

  def tag_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?',"%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def post_params
    params.require(:post).permit(:title, :article_text, :status_id, :category_id,:image).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end