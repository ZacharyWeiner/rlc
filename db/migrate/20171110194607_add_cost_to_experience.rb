class AddCostToExperience < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :cost, :integer
  end
end
