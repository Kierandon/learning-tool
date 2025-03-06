class CreateDailyQuests < ActiveRecord::Migration[8.0]
  def change
    create_table :daily_quests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :quest_type
      t.integer :target_count
      t.integer :current_count
      t.integer :reward_points
      t.boolean :completed
      t.datetime :expires_at

      t.timestamps
    end
  end
end
