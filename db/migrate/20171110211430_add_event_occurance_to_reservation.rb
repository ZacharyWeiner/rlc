class AddEventOccuranceToReservation < ActiveRecord::Migration[5.1]
  def change
    add_reference :reservations, :experience_occurance, foreign_key: true
  end
end
