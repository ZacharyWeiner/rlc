class AddClearTimeToShuttle < ActiveRecord::Migration[5.1]
  def change
    add_column :shuttles, :clear_time, :datetime
  end
end
