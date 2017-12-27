class AddPriorityToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :priority, :integer
  end
end
