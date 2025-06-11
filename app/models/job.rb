class Job < ApplicationRecord
  belongs_to :customer
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by', optional: true
  has_many :inventory_logs
end
