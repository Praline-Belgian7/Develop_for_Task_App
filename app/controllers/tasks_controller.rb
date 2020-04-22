class TasksController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    @tasks = Task.all
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
    @task = Task.find_by(id: @user.id)
  end

  def update
    @user = User.find(params[:user_id])
    @task = Task.find_by(id: @user.id)
    if @task.update_attributes(task_params)
      flash[:success] = "タスクを更新しました。"
      redirect_to user_tasks_path @user
    else
      render :edit
    end
  end
  
  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end
