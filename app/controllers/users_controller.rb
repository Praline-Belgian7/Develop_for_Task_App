class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :un_logged_in_user, only: [:show, :edit, :update, :index, :destroy]
  before_action :logged_in_user, only: [:new, :create]
  before_action :admin_user, only: [:index, :destroy]
  before_action :correct_user1, only: [:edit, :update]
  
  def show
    unless current_user.admin?
      correct_user1
    end
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to user_url(current_user)
    else
      render :edit
    end
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end
