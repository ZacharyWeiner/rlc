class Experience < ApplicationRecord
  has_and_belongs_to_many :businesses
  has_many :experience_occurances
  has_many :reservations
end
