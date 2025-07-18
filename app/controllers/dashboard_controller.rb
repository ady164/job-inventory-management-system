# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_dashboard") }

  def index
    @confirmed_jobs = Job.includes(job_processes: :job_process_type).where(status: 'Confirmed').order(required_date: :asc)
    @inventories = Inventory.where("quantity <= alert_quantity")
    @inventories = Inventory.where("quantity <= alert_quantity")

    @equipments = Equipment.all.select do |e|
      (e.days_since_last - e.calibration_frequency_days) >= -7
    end
  end
  def refresh
    @confirmed_jobs = Job.includes(job_processes: :job_process_type).where(status: 'Confirmed').order(required_date: :asc)
    @inventories = Inventory.where("quantity <= alert_quantity")
    @inventories = Inventory.where("quantity <= alert_quantity")

    @equipments = Equipment.all.select do |e|
      (e.days_since_last - e.calibration_frequency_days) >= -7
    end

    respond_to do |format|
      format.html { render partial: 'dashboard/dashboard_listings', layout: false }
      format.turbo_stream { render partial: 'dashboard/dashboard_listings', layout: false, formats: [:html] }
    end
  end
end
