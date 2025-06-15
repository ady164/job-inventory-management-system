class JobProcessType < ApplicationRecord
  has_many :job_processes
  validates :name, presence: true
end
