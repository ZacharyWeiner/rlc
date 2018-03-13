class AddImageToLocation < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :image, :text
  end
end
