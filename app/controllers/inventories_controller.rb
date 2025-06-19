class InventoriesController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_inventory") }
  before_action :set_inventory, only: [:show, :edit, :update, :destroy]
  before_action -> { require_permission("edit_inventory") }, only: [:edit, :update]
  before_action -> { require_permission("delete_inventory") }, only: [:destroy]
  before_action -> { require_permission("create_inventory") }, only: [:new, :create]

  def index
    @inventories = Inventory.order(:id)
  end

  def show
    @inventory = Inventory.find(params[:id])

    # Filter by month/year
    if params[:month].present? && params[:year].present?
      start_date = Date.new(params[:year].to_i, params[:month].to_i, 1)
      end_date = start_date.end_of_month
      @inventory_logs = @inventory.inventory_logs.where(status: "Completed", created_at: start_date..end_date)
    else
      @inventory_logs = @inventory.inventory_logs.where(status: "Completed").order(created_at: :desc)
    end
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    if params[:inventory][:image]
      save_uploaded_image(@inventory, params[:inventory][:image])
    end

    if @inventory.save
      redirect_to inventories_path, notice: 'Inventory created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if params[:inventory][:image]
      save_uploaded_image(@inventory, params[:inventory][:image])
    end

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
    params.require(:inventory).permit(:name, :product_number, :brand, :description, :category, :quantity, :alert_quantity, :status)
  end

  def save_uploaded_image(inventory, uploaded_file)
    uploads_dir = Rails.root.join('public', 'uploads')
    FileUtils.mkdir_p(uploads_dir) unless Dir.exist?(uploads_dir)

    filename = "#{SecureRandom.uuid}_#{uploaded_file.original_filename}"
    filepath = uploads_dir.join(filename)

    File.open(filepath, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    inventory.image_path = "/uploads/#{filename}"
  end
end
