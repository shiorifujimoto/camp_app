class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :delete]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :delete]
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
      redirect_to post_path(@post.id), notice: '投稿しました'
    else
      render :new
    end
  end
  
  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to post_path(@post.id), notice: '投稿しました'
    else
      render :new
    end
  end

  def show
    @like = Like.new
    @favorite = Favorite.new
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
  end
  
  def update
    # チェックボックスの分岐
    if params[:post][:image_ids]
      params[:post][:image_ids].each do |image_id|
        image = @post.images.find(image_id)
        image.purge
      end
    end
    if @post.update(post_params)
      redirect_to post_path(@post.id), notice: '編集しました'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, notice:"削除しました"
  end
  
  def tag_search
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?',"%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def post_params
    params.require(:post).permit(:title, :article_text, :status_id, :category_id, images: []).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    redirect_to root_path unless current_user == @post.user
  end
end