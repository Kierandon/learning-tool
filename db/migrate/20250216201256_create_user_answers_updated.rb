class CreateUserAnswersUpdated < ActiveRecord::Migration[8.0]
  def change
    create_table :user_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
      t.text :answer_data
      t.boolean :correct
      t.timestamps
    end
  end
end
