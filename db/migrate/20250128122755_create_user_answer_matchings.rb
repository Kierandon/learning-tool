class CreateUserAnswerMatchings < ActiveRecord::Migration[8.0]
  def change
    create_table :user_answer_matchings do |t|
      t.references :user_answer, null: false, foreign_key: true
      t.references :matching, null: false, foreign_key: true
      t.integer :matched_with_id

      t.timestamps
    end
  end
end
