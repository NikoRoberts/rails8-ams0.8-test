class TasksController < ApplicationController
  def index
    @tasks = Task.includes(:user, :bids => :user).all
    render json: @tasks, each_serializer: TaskSerializer
  end

  def show
    @task = Task.includes(:user, :bids => :user).find(params[:id])
    render json: @task, serializer: TaskSerializer
  end
end
