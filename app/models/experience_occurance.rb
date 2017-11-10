class ExperienceOccurance < ApplicationRecord
  belongs_to :experience
  has_many :reservations
end
