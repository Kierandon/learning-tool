class AddStreakDataToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :current_streak, :integer, default: 0
    add_column :users, :last_answer_date, :date
    add_column :users, :highest_streak, :integer, default: 0
  end
end
