class AddBusinessToLocation < ActiveRecord::Migration[5.1]
  def change
    add_reference :locations, :business, foreign_key: true
  end
end
