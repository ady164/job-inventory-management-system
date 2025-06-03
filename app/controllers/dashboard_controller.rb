# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_dashboard") }

  def index
    # Show dashboard content
  end
end
