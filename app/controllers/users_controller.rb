class UsersController < ApplicationController
  before_action :set_user, only:[:show, :edit, :update] 
  def index
    @posts = Post.all.order(created_at: :desc)
    current
  end

  def edit
  end

  def update
    if @user.update(user_params)
      bypass_sign_in(@user)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
 
  def show
    @posts = Post.where(user_id: @user.id)
  end
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :last_name, :first_name, :profile, :email,:password, :avatar)
  end

  def current
    @post_user = Post.exists?(user_id: current_user.id) if user_signed_in?
  end

end
