class JobsController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_job") }
  before_action :set_job, only: [:edit, :update, :destroy]
  before_action -> { require_permission("edit_job") }, only: [:edit, :update]
  before_action -> { require_permission("delete_job") }, only: [:destroy]
  before_action -> { require_permission("create_job") }, only: [:new, :create]

  def index
    # Eager load creator association to avoid N+1 queries
    @jobs = Job.includes(:creator).order(:id)
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.created_by = current_user.id  # Assign creator here, not from params

    if @job.save
      redirect_to jobs_path, notice: 'Job created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @job.update(job_params)
      redirect_to jobs_path, notice: 'Job updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    redirect_to jobs_path, notice: 'Job was successfully deleted.'
  end

  private

  def set_job
    @job = Job.find_by(id: params[:id])
    unless @job
      redirect_to jobs_path, alert: "Job not found."
    end
  end

  def job_params
    # Remove :created_by from permitted params — set it in controller directly
    params.require(:job).permit(
      :customer_id,
      :job_reference_number,
      :vessle_name,
      :required_date,
      :part_type,
      :part_model,
      :part_name,
      :base_material,
      :filler_material,
      :notes,
      :status
    )
  end
end
