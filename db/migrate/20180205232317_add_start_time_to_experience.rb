class AddStartTimeToExperience < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :start_time, :time
  end
end
