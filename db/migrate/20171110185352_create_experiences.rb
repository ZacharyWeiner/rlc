class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :title
      t.integer :duration
      t.integer :capacity
      t.text :description

      t.timestamps
    end
  end
end
