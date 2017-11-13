class ShuttleStop < ApplicationRecord
  belongs_to :shuttle, optional: true

   geocoded_by :address   # can also be an IP address
   after_validation :geocode          # auto-fetch coordinates
end
