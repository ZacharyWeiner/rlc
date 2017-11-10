class CreateExperienceIdeas < ActiveRecord::Migration[5.1]
  def change
    create_table :experience_ideas do |t|
      t.string :title
      t.integer :duration
      t.references :category, foreign_key: true
      t.integer :capacity
      t.text :description

      t.timestamps
    end
  end
end
