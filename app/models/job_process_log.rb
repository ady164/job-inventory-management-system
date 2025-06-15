class JobProcessLog < ApplicationRecord
  belongs_to :job_process
  belongs_to :user

  serialize :measurement_data, JSON
  serialize :process_parameter, JSON
end
