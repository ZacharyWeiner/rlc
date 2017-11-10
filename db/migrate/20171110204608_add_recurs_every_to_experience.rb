class AddRecursEveryToExperience < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :recurrs_every, :string
  end
end
