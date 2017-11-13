class CreateShuttles < ActiveRecord::Migration[5.1]
  def change
    create_table :shuttles do |t|
      t.float :current_lat
      t.float :current_long
      t.float :previous_lat
      t.float :previous_long
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
