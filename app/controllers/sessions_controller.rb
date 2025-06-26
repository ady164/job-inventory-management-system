class SessionsController < ApplicationController
  before_action :prevent_back_button_cache, only: [:new]

  def new
    # render :new
    if current_user
    redirect_to dashboard_path # or whatever path you want
  end

  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      log_user_event(user, true, "Login success")
      redirect_to root_path, notice: "Logged in!"
    else
      log_user_event(nil, false, "Invalid credentials", params[:email])
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity 
    end
  end

  def destroy
    if current_user
      log_user_event(current_user, true, "User logged out")
    end
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out!"
  end

  private

  def prevent_back_button_cache
    response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def log_user_event(user, success, message, email_override = nil)
      UserLog.create(
        user: user,
        login_email: email_override || user&.email,
        success: success,
        message: message,
        attempted_at: Time.current
      )
  end
end
