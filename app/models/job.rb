class Job < ApplicationRecord
  belongs_to :customer
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by', optional: true
  has_many :inventory_logs
  has_many :job_processes
  has_one :job_measurement_reference

  validates :customer_id, presence: true
  validates :job_reference_number, presence: true, uniqueness: true
  validates :status, presence: true
end
