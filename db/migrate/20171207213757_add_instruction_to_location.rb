class AddInstructionToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :instruction, :text
  end
end
