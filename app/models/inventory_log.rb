class InventoryLog < ApplicationRecord
  belongs_to :inventory
  belongs_to :user
  belongs_to :job
end
