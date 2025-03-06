class CreateAchievements < ActiveRecord::Migration[8.0]
  def change
    create_table :achievements do |t|
      t.string :name, null: false
      t.text :description
      t.string :achievement_type, null: false
      t.integer :threshold
      t.string :icon_identifier

      t.timestamps
    end

    add_index :achievements, :achievement_type
  end
end
