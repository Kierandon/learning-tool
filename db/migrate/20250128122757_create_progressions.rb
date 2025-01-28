class CreateProgressions < ActiveRecord::Migration[8.0]
  def change
    create_table :progressions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.references :current_step, foreign_key: { to_table: :steps }
      t.timestamp :completed_at

      t.timestamps
    end

    add_index :progressions, [ :user_id, :course_id ], unique: true
  end
end
