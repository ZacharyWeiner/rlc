class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.string :name
      t.string :phone
      t.references :experience, foreign_key: true
      t.integer :count

      t.timestamps
    end
  end
end
