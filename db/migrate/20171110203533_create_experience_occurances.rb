class CreateExperienceOccurances < ActiveRecord::Migration[5.1]
  def change
    create_table :experience_occurances do |t|
      t.references :experience, foreign_key: true
      t.date :date
      t.integer :capacity

      t.timestamps
    end
  end
end
