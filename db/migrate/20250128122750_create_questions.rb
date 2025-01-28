class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :step, null: false, foreign_key: true
      t.string :question_type
      t.text :question_text
      t.integer :position

      t.timestamps
    end
  end
end
