class Inventory < ApplicationRecord
  has_many :inventory_logs
  has_one_attached :image

  validates :name, :product_number, :brand, :category, :alert_quantity, :status, :unit_cost, presence: true

  # Default quantity to 0 if nil or blank
  before_validation :default_quantity_to_zero

  private

  def default_quantity_to_zero
    self.quantity = 0 if quantity.blank?
  end
end
