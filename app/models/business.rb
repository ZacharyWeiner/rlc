class Business < ApplicationRecord
  belongs_to :location
  belongs_to :category
  has_and_belongs_to_many :experiences
end
