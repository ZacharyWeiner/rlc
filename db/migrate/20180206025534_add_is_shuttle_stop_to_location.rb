class AddIsShuttleStopToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :is_shuttle_stop, :boolean
  end
end
