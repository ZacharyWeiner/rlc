class ExperienceOccurance < ApplicationRecord
  belongs_to :experience
  has_many :reservations

  def available_tickets
    reserved_tickets = 0
    self.reservations.each do |reservation|
      reserved_tickets = reserved_tickets + reservation.count
    end
    return self.capacity - reserved_tickets
  end
end
