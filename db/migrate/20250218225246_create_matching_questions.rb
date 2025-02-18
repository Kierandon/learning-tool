class CreateMatchingQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :matching_questions do |t|
      t.text :success_message
      t.text :failure_message
      t.timestamps
    end

    create_table :matching_pairs do |t|
      t.references :matching_question, null: false, foreign_key: true
      t.text :term
      t.text :definition
      t.integer :position
      t.timestamps
    end
  end
end
