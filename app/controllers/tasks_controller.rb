class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.order("created_at DESC") if user_signed_in?
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)

    if @task.save
      redirect_to @task, notice: "Task successfuly created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect @task, notice: "Task successfuly updated!"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path, notice: "Task deleted!"
  end

  private

    def task_params
      params.require(:task).permit(:title, :description)
    end

    def find_task
      @task = current_user.tasks.find(params[:id])
    end

end
