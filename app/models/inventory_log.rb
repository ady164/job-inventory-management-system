class InventoryLog < ApplicationRecord
  belongs_to :inventory
  belongs_to :user
end
