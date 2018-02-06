class Business < ApplicationRecord
  belongs_to :location, optional: true
  belongs_to :category
  has_and_belongs_to_many :experiences
  mount_uploader :logo, LogoUploader
end
