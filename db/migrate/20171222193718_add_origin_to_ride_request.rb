class AddOriginToRideRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :ride_requests, :origin, :string
  end
end
