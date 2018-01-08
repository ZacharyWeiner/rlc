class AddPaySoundToBusinessSetting < ActiveRecord::Migration[5.1]
  def change
    add_column :business_settings, :play_sound, :boolean
  end
end
