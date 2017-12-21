class AddNoteToRideRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :ride_requests, :note, :text

  end
end
