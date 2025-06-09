class JobProcess < ApplicationRecord
  belongs_to :process_type
  belongs_to :job
  belongs_to :machine
end
