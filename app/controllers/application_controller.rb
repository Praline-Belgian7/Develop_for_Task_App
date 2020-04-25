class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  # paramsハッシュからユーザーを取得します。
  def set_user
    @user = User.find(params[:id])
  end
  
  #未ログインのユーザーと判断した場合
  def un_logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  #ログイン済みのユーザーと判断した場合
  def logged_in_user
    if logged_in?
      flash[:info] = "すでにログインしています。"
      redirect_to user_url(current_user)
    end
  end
  
  #システム管理権限所有かどうか判定する
  def admin_user
    redirect_to root_url unless current_user.admin?
    flash[:danger] = 'アクセス権限がありません。' unless current_user.admin?
  end
  
  # アクセスしたユーザーが現在ログインしているユーザーか確認します。
  def correct_user
    redirect_to root_url unless current_user?(@user)
  end
  
end
