class Experience < ApplicationRecord
  has_and_belongs_to_many :businesses
  has_and_belongs_to_many :categories
  has_many :experience_occurances
  has_many :reservations
  has_many :images
  mount_uploader :header_image, ImageUploader
end
