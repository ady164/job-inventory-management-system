class Equipment< ApplicationRecord
    def days_since_last
    return nil unless last_calibration_date
    (Date.today - last_calibration_date).to_i
  end
end
