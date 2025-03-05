class CreateOrderingQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :ordering_questions do |t|
      t.text :success_message
      t.text :failure_message
      t.timestamps
    end

    create_table :ordering_items do |t|
      t.references :ordering_question, null: false, foreign_key: true
      t.text :content, null: false
      t.integer :correct_position, null: false
      t.timestamps
    end
  end
end
