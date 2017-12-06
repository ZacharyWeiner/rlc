class CreateTrackers < ActiveRecord::Migration[5.1]
  def change
    create_table :trackers do |t|
      t.references :shuttle, foreign_key: true
      t.float :lat
      t.float :long

      t.timestamps
    end
  end
end
