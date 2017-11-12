class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :experience, foreign_key: true
      t.text :file
      t.string :image_type

      t.timestamps
    end
  end
end
