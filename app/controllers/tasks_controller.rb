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
  
  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

end
