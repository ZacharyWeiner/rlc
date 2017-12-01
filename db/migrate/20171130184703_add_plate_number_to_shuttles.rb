class AddPlateNumberToShuttles < ActiveRecord::Migration[5.1]
  def change
    add_column :shuttles, :plate_number, :string
  end
end
