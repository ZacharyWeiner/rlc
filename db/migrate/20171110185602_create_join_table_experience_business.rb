class CreateJoinTableExperienceBusiness < ActiveRecord::Migration[5.1]
  def change
    create_join_table :experiences, :businesses do |t|
      # t.index [:experience_id, :business_id]
      # t.index [:business_id, :experience_id]
    end
  end
end
