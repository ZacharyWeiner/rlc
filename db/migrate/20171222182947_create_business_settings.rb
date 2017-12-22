class CreateBusinessSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :business_settings do |t|
      t.boolean :ride_request_active
      t.string :title

      t.timestamps
    end
  end
end
