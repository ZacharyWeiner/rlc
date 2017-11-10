class AddBusinessTypeToBusiness < ActiveRecord::Migration[5.1]
  def change
    add_column :businesses, :business_type, :string
  end
end
