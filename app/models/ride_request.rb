class RideRequest < ApplicationRecord
  belongs_to :shuttle, optional: true
  attr_accessor :pickup_location_name
end
