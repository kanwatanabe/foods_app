# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[update destroy
                                              following followers]
  before_action :correct_user,   only: %i[update]

  before_action :logged_in_user, only: %i[index update destroy
                                          following followers]

  before_action :admin_user,     only: :destroy

  def index
      @q = User.ransack(params[:q])
      @users = @q.result(distinct: true).page(params[:page]).per(12)
  end

  def show
    @user = User.find(params[:id])
    @microposts = Kaminari.paginate_array(@user.microposts).page(params[:page]).per(9)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def following
    @title = 'フォロー'
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'フォロワー'
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def liking
    @title = '「いいね」した投稿'
    @user  = User.find(params[:id])
    #いいねした投稿を取得
    @microposts = current_user.like_microposts.page(params[:page]).per(9)
    render 'liking_microposts'
  end

  private

  # beforeアクション

  # 正しいユーザーかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
