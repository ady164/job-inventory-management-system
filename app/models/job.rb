class Job < ApplicationRecord
  belongs_to :customer
  belongs_to :creator, class_name: 'User', foreign_key: 'created_by', optional: true
  has_many :inventory_logs
  has_many :job_processes, dependent: :destroy
  has_one :job_measurement_reference, dependent: :destroy

  validates :customer_id, presence: true
  validates :job_reference_number, presence: true, uniqueness: true
  validates :status, presence: true

  has_many :job_process_log, dependent: :destroy
  
  def current_process
    processes = job_processes.sort_by(&:order_index)
    processes.find { |p| p.status == 'Not Completed' } ||
      processes.reverse.find { |p| p.status == 'Completed' }
  end
end
