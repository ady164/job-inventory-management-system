class Admin::RolesController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_admin") }
  before_action :set_role, only: [:edit, :update, :destroy]
  before_action -> { require_permission("edit_admin") }, only: [:edit, :update]
  before_action -> { require_permission("delete_admin") }, only: [:destroy]
  before_action -> { require_permission("create_admin") }, only: [:new, :create]

  def index
    @roles = Role.order(:id)
  end

  def new
    @role = Role.new
    @permissions = Permission.all
  end

  def edit
    @permissions = Permission.all
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      @role.permissions = Permission.where(id: params[:role][:permission_ids])
      redirect_to admin_roles_path, notice: 'Role created successfully.'
    else
      render :new
    end
  end

  def update
    if @role.update(role_params)
      @role.permissions = Permission.where(id: params[:role][:permission_ids])
      redirect_to admin_roles_path, notice: 'Role updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @role.destroy
    redirect_to admin_roles_path, notice: 'Role deleted.'
  end

  private

  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name)
  end
end
