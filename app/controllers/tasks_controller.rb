class TasksController < ApplicationController

  before_action :set_user_task
  before_action :un_logged_in_user
  before_action :correct_user1, only: [:index, :new, :create, :show, :destroy]
  before_action :correct_user2, only: [:edit, :update]
  
  
  def index
    @tasks = Task.where(user_id: @user.id).order(created_at: :desc)
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = @user.id
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_url @user
    else
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_task_url(@user.id, @task.id)
    else
      render :edit
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_url @user
  end
  
  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end
