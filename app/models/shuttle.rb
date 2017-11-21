class Shuttle < ApplicationRecord
  has_many :ride_requests
  reverse_geocoded_by :current_lat, :current_long
  after_validation :reverse_geocode  # auto-fetch address


  def available_seats
    riders = 0
    self.ride_requests.where(status: "Rolling").each do |request|
      riders = riders + request.riders
    end
    return self.capacity - riders
  end
end
