class TasksController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @tasks = Task.where(user_id: @user.id).order(created_at: :desc)
  end
  
  def new
    @user = User.find(params[:user_id])
    @task = Task.new
  end

  def create
    @user = User.find(params[:user_id])
    @task = Task.new(task_params)
    @task.user_id = @user.id
    if @task.save
      flash[:success] = "タスクを新規作成しました。"
      redirect_to user_tasks_path @user
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_tasks_path @user
    else
      render :edit
    end
  end
  
  def show
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @task = Task.find(params[:id])
    @task.destroy
    flash[:success] = "タスクを削除しました。"
    redirect_to user_tasks_path @user
  end
  
  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end
