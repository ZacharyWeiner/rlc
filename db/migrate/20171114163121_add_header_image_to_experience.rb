class AddHeaderImageToExperience < ActiveRecord::Migration[5.1]
  def change
    add_column :experiences, :header_image, :text
  end
end
