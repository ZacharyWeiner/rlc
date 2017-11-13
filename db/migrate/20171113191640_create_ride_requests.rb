class CreateRideRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :ride_requests do |t|
      t.string :pickup_address
      t.string :dropoff_address
      t.integer :riders
      t.string :requester_name
      t.references :shuttle, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
