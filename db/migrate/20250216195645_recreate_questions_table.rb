class RecreateQuestionsTable < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :questions, :steps
    drop_table :questions

    create_table :questions do |t|
      t.references :step, null: false, foreign_key: true
      t.text :prompt
      t.integer :position
      t.references :questionable, polymorphic: true, null: false
      t.timestamps

      t.index [ :questionable_type, :questionable_id ]
    end
  end
end
