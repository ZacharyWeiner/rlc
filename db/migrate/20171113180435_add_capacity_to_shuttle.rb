class AddCapacityToShuttle < ActiveRecord::Migration[5.1]
  def change
    add_column :shuttles, :capacity, :integer
  end
end
