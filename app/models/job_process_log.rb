class JobProcessLog < ApplicationRecord
  belongs_to :job_process
  belongs_to :user
end
