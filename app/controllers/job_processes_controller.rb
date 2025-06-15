class JobProcessesController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_jobprocess") }
  # before_action :set_job_process, only: [:edit, :update, :destroy]
  # before_action -> { require_permission("edit_jobprocess") }, only: [:edit, :update]
  # before_action -> { require_permission("delete_jobprocess") }, only: [:destroy]
  # before_action -> { require_permission("create_jobprocess") }, only: [:new, :create]

  def index
    @jobs = Job.where(status: 'Confirmed').order(created_at: :desc)
  end

    # @job = Job.find(params[:id])
  def show
    @job = Job.find(params[:id])
    @job_processes = @job.job_processes.includes(:machine, :process_type)
    @measurement_types = MeasurementType.where(name: ["Runout", "Diameter", "Length"])
  end


  def update_measurements
    @job_process = JobProcess.find(params[:id])
    @measurement_types = MeasurementType.where(name: ["Runout", "Diameter", "Length"]).index_by(&:name)

    measurements = params[:measurements] || {}

    JobMeasurement.transaction do
      measurements.each do |type_name, rows|
        rows.each do |index, data|
          next if data[:name].blank? && data[:value].blank?

          JobMeasurement.create!(
            job_process: @job_process,
            measurement_type: @measurement_types[type_name],
            order_index: index.to_i,
            measurement_index: index.to_i,
            name: data[:name],
            value: data[:value],
            remarks: data[:remarks]
          )
        end
      end
    end

    redirect_to job_process_path(@job_process), notice: "Measurements saved successfully."
  rescue => e
    redirect_to job_process_path(@job_process), alert: "Failed to save measurements: #{e.message}"
  end
  
  def upload_photos
  job = Job.find(params[:id])
  folder = Rails.root.join("public", "jobs", job.job_reference_number)

  FileUtils.mkdir_p("#{folder}/incoming")
  FileUtils.mkdir_p("#{folder}/drawings")

  if params[:incoming_photos]
    params[:incoming_photos].each do |photo|
      File.open("#{folder}/incoming/#{photo.original_filename}", "wb") do |file|
        file.write(photo.read)
      end
    end
  end

  if params[:drawing_photos]
    params[:drawing_photos].each do |photo|
      File.open("#{folder}/drawings/#{photo.original_filename}", "wb") do |file|
        file.write(photo.read)
      end
    end
  end

  redirect_back fallback_location: job_processes_path, notice: 'Photos uploaded successfully.'
end
end


# class JobProcessesController < ApplicationController
#   before_action :set_job_process, only: [:show, :update_measurements, :log_process]

#   # GET /job_processes
#   # List jobs with status "confirmed" and their associated processes
#   def index
#     @jobs = Job.includes(job_processes: :job_process_type)
#                .where(status: "Confirmed")
#                .order(created_at: :desc)
#   end

#   # GET /job_processes/:id
#   # Show a single job process, with its job and sibling processes
#   def show
#     @job = Job.find(params[:id])
#     @job_processes = @job.job_processes.includes(:job_process_type)
#   end

#   # GET /job_processes/available_process_types
#   # Return JSON list of available process types (for dropdowns)
#   def available_process_types
#     types = JobProcessType.order(:sequence_index)
#     render json: types.as_json(only: [:id, :name])
#   end

#   # POST /job_processes/add_to_job
#   # Create a new job process for the given job and process type
#   def add_to_job
#     job = Job.find(params[:job_id])
#     process_type = JobProcessType.find(params[:job_process_type_id])

#     new_process = JobProcess.create!(
#       job: job,
#       job_process_type: process_type,
#       order_index: job.job_processes.maximum(:order_index).to_i + 1,
#       status: 'pending'
#     )

#     render json: { id: new_process.id, name: process_type.name }
#   end

#   # PATCH /job_processes/:id/update_measurements
#   # Save or update measurements for a job process
#   def update_measurements
#     measurements = params[:measurements] || []

#     measurements.each do |m|
#       measurement = @job_process.job_measurements.find_or_initialize_by(
#         name: m[:name],
#         measurement_type_id: m[:measurement_type_id],
#         measurement_index: m[:measurement_index]
#       )
#       measurement.assign_attributes(
#         value: m[:value],
#         remarks: m[:remarks],
#         order_index: m[:order_index]
#       )
#       measurement.save!
#     end

#     render json: { status: 'ok' }
#   end

#   # POST /job_processes/:id/log_process
#   # Log the start/end time and measurement/process data for auditing
#   def log_process
#     JobProcessLog.create!(
#       job_process: @job_process,
#       user: current_user,
#       start_time: params[:start_time],
#       end_time: params[:end_time],
#       measurement_data: params[:measurement_data],
#       process_parameter: params[:process_parameter],
#       status: params[:status]
#     )

#     render json: { status: 'logged' }
#   end

#   private

#   def set_job_process
#   @job_process = JobProcess.includes(:job, :job_process_type, job_measurements: :measurement_type).find(params[:id])
# rescue ActiveRecord::RecordNotFound
#   redirect_to jobs_path, alert: "Job Process not found."
# end

# end

