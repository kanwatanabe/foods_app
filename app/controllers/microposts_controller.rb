# frozen_string_literal: true

class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def new
    @micropost = current_user.microposts.build if user_signed_in?
  end

  def show
    @comment = Comment.new
    @micropost = Micropost.find(params[:id])
    @comments = @micropost.comments
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '投稿しました！！'
      redirect_to current_user
    else
      render new_micropost_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = '投稿を消去しました。'
    redirect_to request.referer || root_url
  end

  def micropost_params
    params.require(:micropost).permit(:content, :picture, :tag_list)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end
