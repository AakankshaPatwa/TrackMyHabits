class AddUniqueIndexToHabitsNamePerUser < ActiveRecord::Migration[8.0]
  def change
    add_index :habits, [:user_id, :name], unique: true
  end
end