class RideRequest < ApplicationRecord
  belongs_to :shuttle, optional: true
end
