# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # deviseで名前を追加するために追記
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name profile email image])

    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image])
  end

  private

  # beforeフィルター

  # 正しいユーザーかどうかを確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうかを確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # ユーザーのログインを確認する
  def logged_in_user
    return if user_signed_in?

    tore_location
    flash[:danger] = 'ログインしてください'
    redirect_to login_url
  end
end
