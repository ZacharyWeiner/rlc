class CreateShuttleStops < ActiveRecord::Migration[5.1]
  def change
    create_table :shuttle_stops do |t|
      t.references :shuttle, foreign_key: true
      t.integer :order
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :person_count

      t.timestamps
    end
  end
end
