class JobProcessLogsController < ApplicationController
  def create
    # Use nested params if available, else fallback to flat params
    log_params = params[:job_process_log] || params

    @log = JobProcessLog.new(
      job_process_id: log_params[:job_process_id],
      user_id: current_user.id,
      start_time: log_params[:start_time],
      end_time: log_params[:end_time],
      measurement_data: JSON.parse(log_params[:measurement_data].presence || "{}"),
      status: "Completed"
    )

    if @log.save
      render json: { success: true }
    else
      render json: { error: @log.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def job_process_log_params
    params.require(:job_process_log).permit(:job_process_id, :start_time, :end_time, :status, :process_parameter, :measurement_data)
  end
end
