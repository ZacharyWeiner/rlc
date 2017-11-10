class AddPaidAndChargeIdToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :paid, :boolean
    add_column :reservations, :charge_id, :bigint
  end
end
