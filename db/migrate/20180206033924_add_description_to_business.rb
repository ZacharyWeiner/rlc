class AddDescriptionToBusiness < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :description, :text
  end
end
