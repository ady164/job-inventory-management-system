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
    @job_processes = @job.job_processes.includes(:equipment).order(order_index: :asc)
    @job_process_types = JobProcessType.where.not(name: "INCOMING")
    @reference = JobMeasurementReference.find_by(job_id: @job.id)
    @equipment = Equipment.where(equipment_type: "Machine")
    @jobstart = JobProcessLog.where.not(job_process_id: 1).order(start_time: :asc).first
  end

  def create_process
    @equipment = Equipment.where(equipment_type: "Machine")
    @job_process = JobProcess.create!(
      job_id: params[:job_id],
      job_process_type_id: params[:job_process_type_id],
      order_index: JobProcess.where(job_id: params[:job_id]).maximum(:order_index).to_i + 1,
      status: "Not Completed"
    )

    @reference = JobMeasurementReference.find_by(job_id: @job_process.job_id)

    html = render_to_string(
      partial: 'job_processes/process_form',
      locals: { process: @job_process, i: @job_process.order_index, reference: @reference },
      formats: [:html]
    )

    render json: {
      success: true,
      html: html,
      job_process_type_id: @job_process.job_process_type_id,
      order_index: @job_process.order_index,
      diameter_reference: @reference&.diameter.to_json,
      length_reference: @reference&.length.to_json,
      measurement_data: @job_process.measurements.to_json
    }
  end


  def update_process
    job_process = JobProcess.find(params[:job_process_id])
    job_id = params[:job_id]
    job_process_id = params[:job_process_id]
    equipment_id = params[:equipment_id]
    start_time = params[:start_time]
    end_time = params[:end_time]
    # diameter_reference = params[diameter_reference]
    # length_reference = params[length_reference]
    # measurements = params[measurements]
    measurement_data = params[:measurement_data]
    user_id = 1
    reference_keys = %w[point minimum maximum]

    diameter_reference = []
    length_reference = []
    measurements = {}

    measurement_data.each do |type, entries|
      ref_list = []
      meas_list = []

      entries.each do |entry|
        ref_list << entry.slice(*reference_keys)
        meas_list << entry.reject { |k, _| reference_keys.include?(k) }
      end

      measurements[type] = meas_list
      case type
      when "diameter"
        diameter_reference = ref_list
      when "length"
        length_reference = ref_list
      end
    end

    puts "diameter_reference:"
    puts diameter_reference
    puts "length_reference:"
    puts length_reference
    puts "measurements:"
    puts measurements

    # Update job_process
    if job_process.update(
      equipment_id: equipment_id,
      start_time: start_time,
      end_time: end_time,
      measurements: measurements,
      status: "Completed"
    )
      # Update or create Job Measurement Reference
      ref = JobMeasurementReference.find_by(job_id: job_id)
      if ref
        ref.update(diameter: diameter_reference, length: length_reference)
      else
        JobMeasurementReference.create(job_id: job_id, diameter: diameter_reference, length: length_reference)
      end
      # Create log
      JobProcessLog.create!(
        job_process_id: job_process_id,
        user_id: user_id,
        start_time: start_time,
        end_time: end_time,
        measurement_data: measurement_data,
        status: "Completed"
      )
      render json: { success: true, job_process: job_process }
    else
      render json: { success: false, errors: job_process.errors.full_messages }, status: :unprocessable_entity
    end
  rescue => e
    Rails.logger.error "❌ update_process error: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render json: { success: false, error: e.message }, status: :internal_server_error
  end

  # def update
  #   @job_process = JobProcess.find_by(job_id:params[:id])

  #   if @job_process.update(measurements: params[:measurement_data].present? ? JSON.parse(params[:measurement_data]) : {})
  #     render json: { status: "ok" }
  #   else
  #     render json: { status: "error", errors: @job_process.errors }, status: :unprocessable_entity
  #   end
  # end
  
  def create_log
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

  private

  def set_job_process_log
    @job_process_log = JobProcessLog.find(params[:id])
  end

  def job_process_log_params
    params.require(:job_process_log).permit(
      :job_process_id,
      :start_time,
      :end_time,
      :status,
      :measurement_data
    )
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

