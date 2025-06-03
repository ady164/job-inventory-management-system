class Inventory < ApplicationRecord
  has_one_attached :image

  validates :name, :product_number, :category, :alert_quantity, :status, presence: true

  # Default quantity to 0 if nil or blank
  before_validation :default_quantity_to_zero

  private

  def default_quantity_to_zero
    self.quantity = 0 if quantity.blank?
  end
end
