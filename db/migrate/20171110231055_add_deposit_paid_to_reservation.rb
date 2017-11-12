class AddDepositPaidToReservation < ActiveRecord::Migration[5.1]
  def change
    add_column :reservations, :deposit_paid, :boolean
  end
end
