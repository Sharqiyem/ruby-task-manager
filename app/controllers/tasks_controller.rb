
class TasksController < ApplicationController 
  load_and_authorize_resource
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_status]
  before_action :authenticate_user!
  before_action :authorize_user, only: [:edit, :update, :destroy]
  # GET /tasks or /tasks.json
  def index
    @tasks = current_user.tasks
      .order(created_at: :desc)
      .filter_by_status(params[:status])
      .filter_by_priority(params[:priority])
  end


  # GET /tasks/1 or /tasks/1.json
  def show
    @task = Task.find_by(id: params[:id])
  
    if @task.nil?
      redirect_to tasks_path, alert: "Task not found"
    end
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.new
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks or /tasks.json
  # before_action :authenticate_user!
  # load_and_authorize_resource # For CanCanCan if using authorization
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to @task, notice: "Task was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_status
    @task = Task.find(params[:id])
  
  respond_to do |format|
    if @task.update(status: params[:status])
      format.json { render json: { success: true, message: 'Status updated' } }
    else
      format.json { render json: { success: false, errors: @task.errors.full_messages }, status: :unprocessable_entity }
    end
  end
  rescue => e
  Rails.logger.error "Error updating task status: #{e.message}"
  render json: { success: false, error: e.message }, status: :internal_server_error
  end

  def dashboard
    @total_tasks = current_user.tasks.count
    @completed_tasks = current_user.tasks.done.count
    @pending_tasks = current_user.tasks.where.not(status: :done).count
    @tasks_by_priority = current_user.tasks.group(:priority).count
  end
 
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      respond_to do |format|
        format.html { redirect_to tasks_path, alert: 'Task not found.' }
        format.json { render json: { success: false, error: 'Task not found' }, status: :not_found }
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :status, :priority, :assignee_id)
    end

    def authorize_user
      unless @task.user == current_user
        redirect_to tasks_path, alert: "Not authorized"
      end
    end
end
