class RideRequest < ApplicationRecord
  belongs_to :shuttle, optional: true
  attr_accessor :pickup_location_name

  validate :pickup_and_droppoff_required

  def pickup_and_droppoff_required
    if (pickup_address.present? == false || pickup_address == "-- Please Select --")
      errors.add(:pickup_address, "Pickup Address Required")
    end
    if (dropoff_address.present? == false || dropoff_address == "-- Please Select --")
      errors.add(:dropoff_address, "Dropoff Address Required")
    end
    if pickup_address == dropoff_address
      errors.add(:dropoff_address, "Dropoff Address Must Be Different From Pickup")
    end
  end

  def advance_status(current_status)
    if current_status == "In Queue"
      self.status = "Dispatched"
    elsif current_status == "Dispatched"
      self.status = "Rolling"
    elsif current_status == "Rolling"
      self.status = "Clear"
      self.completed = true
    end
    self.save
  end
end
