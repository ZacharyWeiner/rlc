class Shuttle < ApplicationRecord
  has_many :ride_requests
  reverse_geocoded_by :current_lat, :current_long
  after_validation :reverse_geocode  # auto-fetch address
end
