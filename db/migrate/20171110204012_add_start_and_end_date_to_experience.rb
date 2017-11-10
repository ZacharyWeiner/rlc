class AddStartAndEndDateToExperience < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :start_date, :date
    add_column :experiences, :end_date, :date
  end
end
