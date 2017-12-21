class AddLoopingToShuttle < ActiveRecord::Migration[5.1]
  def change
    add_column :shuttles, :is_looping, :boolean
  end
end
