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
    @grouped_inventory = InventoryLog.where(job_id: params[:id],operation_type: "Dispense").group(:inventory_id).sum(:quantity)
    @inventories = Inventory.where(id: @grouped_inventory.keys).index_by(&:id)
    
    @processes = JobProcess
      .includes(:user)
      .where(job_id: @job.id)
      .where.not(start_time: nil, end_time: nil, user_id: nil)
    @user_costs = {}
    @processes.each do |process|
      user = process.user
      next unless user

      hours = ((process.end_time - process.start_time) / 3600.0).round(2)

      @user_costs[user] ||= { hours: 0.0, rate: user.man_hour_rate.to_f }
      @user_costs[user][:hours] += hours
    end
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.created_by = current_user.id 

    if @job.save
      create_incoming_process(@job)
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
    @job = Job.find(params[:id])
    @job.job_measurement_references.destroy_all
    @job.job_processes.destroy_all
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

  # Helper method to create the initial JobProcess
  def create_incoming_process(job)
    # Find the JobProcessType for "INCOMING" - ensure it exists and get its ID
    incoming_process_type = JobProcessType.find_by(name: "INCOMING")

    unless incoming_process_type
      # This is a critical error if "INCOMING" process type isn't set up
      job.errors.add(:base, "Error: 'INCOMING' job process type not found. Please configure system.")
      raise ActiveRecord::Rollback # Trigger transaction rollback
    end

    # Create the JobProcess, using the association for job_id assignment
    @job_process = JobProcess.new(
      job_process_type: incoming_process_type, # Assign Job Process type object
      job: job,                                 # Assign Job object
      order_index: 1,
      status: "Not Completed"
    )

    unless @job_process.save
      # If JobProcess saving fails, transfer its errors to the Job object
      # and trigger a rollback of the entire transaction.
      @job_process.errors.full_messages.each do |msg|
        job.errors.add(:base, "Initial process creation failed: #{msg}")
      end
      raise ActiveRecord::Rollback # Trigger transaction rollback
    end
  end
end
