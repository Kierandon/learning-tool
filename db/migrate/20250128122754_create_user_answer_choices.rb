class CreateUserAnswerChoices < ActiveRecord::Migration[8.0]
  def change
    create_table :user_answer_choices do |t|
      t.references :user_answer, null: false, foreign_key: true
      t.references :choice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
