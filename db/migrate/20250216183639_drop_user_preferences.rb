class DropUserPreferences < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :user_preferences, :users
    drop_table :user_preferences
  end
end
