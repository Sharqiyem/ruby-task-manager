class TasksController < ApplicationController 
  load_and_authorize_resource
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :destroy, :update_status]
  before_action :authorize_user, only: [:edit, :destroy]

  def index
    @status_counts = current_user.tasks.status_counts
    @tasks_by_status = Task.statuses.keys.each_with_object({}) do |status, hash|
      hash[status] = current_user.tasks.where(status: status).order(created_at: :desc)
    end
  end

  def show
    @task = Task.find_by(id: params[:id])
    
    if @task.nil?
      redirect_to tasks_path, alert: "Task not found"
    end
  end

  def new
    @task = current_user.tasks.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to @task, notice: "Task was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy!
    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_status
    begin
      if @task.update(status: params[:status])
        render json: { success: true, message: 'Status updated successfully' }
      else
        render json: { success: false, errors: @task.errors.full_messages }, 
               status: :unprocessable_entity
      end
    rescue => e
      Rails.logger.error "Error updating task status: #{e.message}"
      render json: { success: false, error: e.message }, status: :internal_server_error
    end
  end

  def dashboard
    @total_tasks = current_user.tasks.count
    @completed_tasks = current_user.tasks.done.count
    @pending_tasks = current_user.tasks.where.not(status: :done).count
    
    @status_counts = current_user.tasks.group(:status).count
    @priority_counts = current_user.tasks.group(:priority).count
    
    @tasks_by_status = current_user.tasks.group(:status).count
    @completion_rate = calculate_completion_rate
    
    # Recent tasks
    @recent_tasks = current_user.tasks.order(created_at: :desc).limit(5)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  private

  def set_task
     @task = current_user.tasks.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    respond_to do |format|
      format.html { redirect_to tasks_path, alert: 'Task not found.' }
      format.json { render json: { success: false, error: 'Task not found' }, status: :not_found }
    end
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority, :assignee_id)
  end

  def authorize_user
    unless @task.user == current_user
      redirect_to tasks_path, alert: "Not authorized"
    end
  end

  def calculate_completion_rate
    return 0 if @total_tasks == 0
    (@completed_tasks.to_f / @total_tasks * 100).round(1)
  end
end