class UsersController < ApplicationController
  before_action :authenticate_user!, only:[:create, :edit, :update]
  before_action :set_posts, only:[:index]
  before_action :set_user, only:[:show, :edit, :update]
  before_action :identification_user, only:[:edit, :update]
  before_action :set_favorites, only:[:show]
  helper_method :current?

  def index
  end

  def edit
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to user_path(@user.id), notice: '編集しました'
    else
      render :edit
    end
  end
 
  def show
    if current_user == @user
      @posts = Post.where(user_id: @user.id).sort {|a,b| b.liked_users.count <=> a.liked_users.count}
    else
      @posts = Post.where(user_id: @user.id,status_id: 2).sort {|a,b| b.liked_users.count <=> a.liked_users.count}
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :last_name, :first_name, :profile, :email,:password, :avatar)
  end

  def current?
    Post.exists?(user_id: current_user.id)
  end

  def identification_user
    redirect_to root_path unless current_user == @user
  end

  def set_favorites
    @favorites = Post.where(id: @user.favorited_posts.ids, status_id: 2)
  end
end