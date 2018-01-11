class AddEmailToRideRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :ride_requests, :email, :string
  end
end
