class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  #ログイン済みのユーザーか判断する
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_url
    end
  end
  
  #システム管理権限所有かどうか判定する
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
end
