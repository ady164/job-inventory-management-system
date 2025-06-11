class CustomersController < ApplicationController
  before_action :require_login
  before_action -> { require_permission("view_customer") }
  before_action :set_customer, only: [:edit, :update, :destroy]
  before_action -> { require_permission("edit_customer") }, only: [:edit, :update]
  before_action -> { require_permission("delete_customer") }, only: [:destroy]
  before_action -> { require_permission("create_customer") }, only: [:new, :create]

  def index
    @customers = Customer.order(:id)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if params[:customer][:image]
      save_uploaded_image(@customer, params[:customer][:image])
    end

    if @customer.save
      redirect_to customers_path, notice: 'Customer created successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if params[:customer][:image]
      save_uploaded_image(@customer, params[:customer][:image])
    end

    if @customer.update(customer_params)
      redirect_to customers_path, notice: 'Customer updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_path, notice: 'Customer was successfully deleted.'
  end

  private

  def set_customer
    @customer = Customer.find_by(id: params[:id])
    unless @customer
      redirect_to customers_path, alert: "Customer not found."
    end
  end

  def customer_params
    params.require(:customer).permit(:name, :address)
  end

end
