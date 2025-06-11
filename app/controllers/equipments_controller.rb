class EquipmentsController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_equipment") }
  before_action :set_equipment, only: [:edit, :update, :destroy]
  before_action -> { require_permission("edit_equipment") }, only: [:edit, :update]
  before_action -> { require_permission("delete_equipment") }, only: [:destroy]
  before_action -> { require_permission("create_equipment") }, only: [:new, :create]

  def index
    @equipments = Equipment.order(:id)
  end

  def show
    @equipment = Equipment.find(params[:id])
  end

  def new
    @equipment = Equipment.new
  end

  def create
    @equipment = Equipment.new(equipment_params)

    if params[:equipment][:image]
      save_uploaded_image(@equipment, params[:equipment][:image])
    end

    if @equipment.save
      redirect_to equipments_path, notice: 'Equipment created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if params[:equipment][:image]
      save_uploaded_image(@equipment, params[:equipment][:image])
    end

    if @equipment.update(equipment_params)
      redirect_to equipments_path, notice: 'Equipment updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @equipment.destroy
    redirect_to equipments_path, notice: 'Equipment was successfully deleted.'
  end

  private

  def set_equipment
    @equipment = Equipment.find_by(id: params[:id])
    unless @equipment
      redirect_to equipments_path, alert: "Equipment not found."
    end
  end

  def equipment_params
    params.require(:equipment).permit(
      :name,
      :tag,
      :brand,
      :model,
      :serial_number,
      :equipment_type,
      :purchase_date,
      :remarks,
      :last_calibration_date,
      :calibration_frequency_days
    )
  end

end
