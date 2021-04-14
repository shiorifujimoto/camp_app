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
      flash[:success] = "作成しました"
      return redirect_to post_path(@post.id)
    else
      render :new
    end
  end

  def show
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
      flash[:success] = "編集しました"
      redirect_to post_path(@post.id)
    else
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
    params.require(:post).permit(:title, :article_text, :status_id, :category_id, images: []).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end