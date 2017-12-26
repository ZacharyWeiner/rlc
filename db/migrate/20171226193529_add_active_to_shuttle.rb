class AddActiveToShuttle < ActiveRecord::Migration[5.1]
  def change
    add_column :shuttles, :is_active, :boolean
  end
end
