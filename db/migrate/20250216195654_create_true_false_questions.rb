class CreateTrueFalseQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :true_false_questions do |t|
      t.boolean :correct_answer, null: false
      t.text :success_message
      t.text :failure_message
      t.timestamps
    end
  end
end
