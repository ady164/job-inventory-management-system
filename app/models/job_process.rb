class JobProcess < ApplicationRecord
  belongs_to :process_type, class_name: 'JobProcessType', foreign_key: 'process_type_id'
  # belongs_to :process_type, class_name: 'JobProcessType', foreign_key: :process_type_id
  belongs_to :job
  belongs_to :job_process_type
  belongs_to :equipment, optional: true

  has_many :job_measurements, dependent: :destroy
  accepts_nested_attributes_for :job_measurements, allow_destroy: true
  has_many :job_process_logs, dependent: :destroy
end
