class JobMeasurement < ApplicationRecord
  belongs_to :job_process
  belongs_to :measurement_type
end
