# app/controllers/inventorylogs_controller.rb
class Api::InventoryLogsController < ApplicationController
    skip_before_action :verify_authenticity_token  # For API-style access
  
    # GET /inventorylogs
    def index
      render json: InventoryLog.where(operation_type: 'Dispense', status: 'Requested').order(:created_at)
    end

    # POST /inventorylogs
    def create
      inventory_log = InventoryLog.new(params.require(:inventory_log).permit(:inventory_id, :job_id, :user_id, :status, :quantity, :operation_type, :message))
      if inventory_log.save
        render json: inventory_log, status: :created
        update_inventory(inventory_log)
      else
        Rails.logger.error "InventoryLog creation failed: #{inventory_log.errors.full_messages.join(', ')}"
        render json: { errors: inventory_log.errors.full_messages }, status: :unprocessable_entity
      end
    end


    # PATCH /inventorylogs/:id
    def update
      inventory_log = InventoryLog.find(params[:id])
      if inventory_log.update(params.require(:inventory_log).permit(:status))
        render json: inventory_log
      else
        render json: { error: inventory_log.errors }, status: :unprocessable_entity
      end
    end

    # update inventory balance
    def update_inventory(inventory_log)
      inventory = Inventory.find(inventory_log.inventory_id)
      quantity_to_deduct = inventory_log.quantity.to_i

      Rails.logger.info ">>> update_inventory: ID=#{inventory_log.id}, QtyToDeduct=#{quantity_to_deduct}, InventoryID=#{inventory.id}, Available=#{inventory.quantity}"

      if inventory.quantity >= quantity_to_deduct
        success = inventory.update(quantity: inventory.quantity - quantity_to_deduct)
        if success
          Rails.logger.info ">>> Inventory #{inventory.id} updated to #{inventory.quantity}"
        else
          Rails.logger.error ">>> Inventory update failed: #{inventory.errors.full_messages.join(", ")}"
        end
      else
        Rails.logger.warn ">>> Insufficient quantity: Available #{inventory.quantity}, Requested #{quantity_to_deduct}"
      end
    end
  end
  