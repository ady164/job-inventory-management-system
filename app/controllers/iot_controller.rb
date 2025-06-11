require 'digest'

class IotController < ApplicationController
    before_action :set_inventory, only: [:show, :update_quantity]

    def index
        @inventories = Inventory.order(:id)
    end    
    def show
        @inventory = Inventory.find(params[:id])
    end

    def update_quantity
        input_pin = params[:user_pin]
        qty = params[:quantity].to_i
        op_type = params[:operation_type]
        update_status = nil

        # Hash the input PIN to match the stored value
        hashed_input = Digest::SHA256.hexdigest(input_pin)

        user = User.find_by(pin_hash: hashed_input)

        if user.nil?
        flash[:alert] = "Invalid PIN."
        # Log the invalid transaction
        InventoryLog.create!(
        user_id: nil,
        inventory_id: @inventory.id,
        quantity: qty,
        operation_type: op_type,
        message: "Invalid PIN"
        )
        redirect_to iot_path(@inventory) and return
        end

        if op_type == "Dispense"
            if qty <= 0 || qty > @inventory.quantity
            flash[:alert] = "Invalid quantity."
            redirect_to iot_path(@inventory) and return
            end
        end

        # Update inventory
        if op_type == "Dispense"
            @inventory.update(quantity: @inventory.quantity - qty)
            update_status = "Requested"
        elsif op_type == "Restock"
            @inventory.update(quantity: @inventory.quantity + qty)
            update_status = "Completed"
        end

        # Log the successful transaction
        InventoryLog.create!(
        user_id: user.id,
        inventory_id: @inventory.id,
        quantity: qty,
        status: update_status,
        operation_type: op_type,
        message: "#{op_type} request successful.",
        job_id: params[:job_id]
        )
        inventoryname = @inventory.name
        if op_type == "Dispense"
            opname = "dispensed"
        elsif op_type == "Restock"
            opname = "restocked"
        end
        flash[:notice] = "#{inventoryname} #{opname} quantity: #{qty}.\nThank you #{user.name}!"
        redirect_to iot_path(@inventory)
    end

    private

    def set_inventory
        @inventory = Inventory.find(params[:id])
    end
end

