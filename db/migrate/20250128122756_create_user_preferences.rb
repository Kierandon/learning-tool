class CreateUserPreferences < ActiveRecord::Migration[8.0]
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false, foreign_key: true
      t.string :font_size
      t.string :colour_scheme
      t.boolean :high_contrast

      t.timestamps
    end
  end
end
