class Location < ApplicationRecord
  mount_uploader :image, ImageUploader
  geocoded_by :address
  after_validation :geocode
end
