class IotApiController < ApplicationController
    skip_before_action :verify_authenticity_token  # For API-style access
  
    # GET /transactions
    def index
      render json: Transaction.where(operation_type: 'Dispense').order(:created_at)
    end

    # POST /transactions
    def create
      transaction = Transaction.new(params.require(:transaction).permit(:inventory_id, :quantity, :operation_type))
      if transaction.save
        render json: transaction, status: :created
      else
        render json: { error: transaction.errors }, status: :unprocessable_entity
      end
    end

    # PATCH /transactions/:id
    def update
      transaction = Transaction.find(params[:id])
      if transaction.update(params.require(:transaction).permit(:operation_type))
        render json: transaction
      else
        render json: { error: transaction.errors }, status: :unprocessable_entity
      end
    end
    
  end
  