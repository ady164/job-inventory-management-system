class JobMeasurementReference < ApplicationRecord
  belongs_to :job, optional: true
end
