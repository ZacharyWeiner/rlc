class AddPhoneNumberToRideRequests < ActiveRecord::Migration[5.1]
  def change
    add_column :ride_requests, :phone, :string
  end
end
