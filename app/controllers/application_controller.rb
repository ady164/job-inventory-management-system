# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_login
    redirect_to login_path unless current_user
  end

  def require_permission(perm)
    unless current_user&.has_permission?(perm)
      redirect_to root_path, alert: "Access denied"
    end
  end
end
