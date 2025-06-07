class InventoriesController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_dashboard") }
  before_action :set_inventory, only: [:edit, :update, :show]

  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.find(params[:id])
    end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)
    if @inventory.save
      redirect_to inventories_path, notice: 'Inventory created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @inventory.update(inventory_params)
      redirect_to inventories_path, notice: 'Inventory updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @inventory.destroy
    redirect_to inventories_path, notice: 'Inventory was successfully deleted.'
  end


  private

  def set_inventory
    @inventory = Inventory.find_by(id: params[:id])
    unless @inventory
        redirect_to inventories_path, alert: "Inventory not found."
    end
  end


  def inventory_params
    params.require(:inventory).permit(:name, :product_number, :description, :category, :quantity, :alert_quantity, :status)
  end
end
