class Image < ApplicationRecord
  belongs_to :experience, optional: true
  mount_uploader :file, ImageUploader
end
