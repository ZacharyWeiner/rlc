class CreateJoinTableExpereinceCategory < ActiveRecord::Migration[5.1]
  def change
    create_join_table :experiences, :categories do |t|
      # t.index [:experience_id, :category_id]
      # t.index [:category_id, :expereince_id]
    end
  end
end
