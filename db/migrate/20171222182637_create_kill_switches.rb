class CreateKillSwitches < ActiveRecord::Migration[5.1]
  def change
    create_table :kill_switches do |t|
      t.boolean :is_active

      t.timestamps
    end
  end
end
