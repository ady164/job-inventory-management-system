class JobProcessLog < ApplicationRecord
  belongs_to :job_process
  belongs_to :user, optional: true
  
  validates :measurement_data, presence: true, allow_blank: true
  validate :validate_measurement_data_format

  private

  def validate_measurement_data_format
    return if measurement_data.blank?

    unless measurement_data.is_a?(Hash)
      errors.add(:measurement_data, "must be a valid JSON object")
    end
  end
end
