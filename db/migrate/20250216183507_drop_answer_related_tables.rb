class DropAnswerRelatedTables < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :user_answer_choices, :choices
    remove_foreign_key :user_answer_choices, :user_answers
    remove_foreign_key :user_answer_matchings, :matchings
    remove_foreign_key :user_answer_matchings, :user_answers
    remove_foreign_key :user_answers, :questions
    remove_foreign_key :user_answers, :users

    drop_table :user_answer_choices
    drop_table :user_answer_matchings
    drop_table :user_answers
    drop_table :choices
    drop_table :matchings
  end
end
