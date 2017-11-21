class AddStatusToRideRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :ride_requests, :status, :string
  end
end
