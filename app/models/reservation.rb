class Reservation < ApplicationRecord
  belongs_to :experience
  belongs_to :experience_occurance
end
