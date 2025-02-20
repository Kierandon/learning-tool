class CreateMultipleChoiceQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :multiple_choice_questions do |t|
      t.boolean :allow_multiple_answers, default: false, null: false
      t.string :success_message
      t.string :failure_message
      t.timestamps
    end

    create_table :multiple_choice_options do |t|
      t.references :multiple_choice_question, null: false, foreign_key: true
      t.string :text, null: false
      t.boolean :correct, default: false, null: false
      t.text :feedback
      t.timestamps
    end
  end
end
