class Admin::UsersController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_admin") }
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action -> { require_permission("edit_admin") }, only: [:edit, :update]
  before_action -> { require_permission("delete_admin") }, only: [:destroy]
  before_action -> { require_permission("create_admin") }, only: [:new, :create]

  def index
    @users = User.includes(:role).all
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def create
    @user = User.new
    @user.assign_attributes(user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'User created successfully.'
    else
      @roles = Role.all
      render :new
    end
  end

  def edit
    @roles = Role.all
  end

  def update
    Rails.logger.debug "Permitted params: #{user_params.inspect}"
Rails.logger.debug "User respond_to password_confirmation? => #{@user.respond_to?(:password_confirmation=)}"

    @user.assign_attributes(user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'User updated successfully.'
    else
      @roles = Role.all
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted successfully.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :role_id, :password_hash, :pin_hash)
  end

end
