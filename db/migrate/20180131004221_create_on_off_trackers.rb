class CreateOnOffTrackers < ActiveRecord::Migration[5.1]
  def change
    create_table :on_off_trackers do |t|
      t.string :status

      t.timestamps
    end
  end
end
