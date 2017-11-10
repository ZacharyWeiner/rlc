class CreateBusinesses < ActiveRecord::Migration[5.1]
  def change
    create_table :businesses do |t|
      t.string :name
      t.references :location, foreign_key: true
      t.references :category, foreign_key: true
      t.string :contact_name
      t.string :contact_phone

      t.timestamps
    end
  end
end
