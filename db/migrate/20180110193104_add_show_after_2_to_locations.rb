class AddShowAfter2ToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :show_after_2, :boolean
  end
end
