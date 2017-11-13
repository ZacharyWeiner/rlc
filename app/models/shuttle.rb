class Shuttle < ApplicationRecord
  reverse_geocoded_by :current_lat, :current_long
  after_validation :reverse_geocode  # auto-fetch address
end
