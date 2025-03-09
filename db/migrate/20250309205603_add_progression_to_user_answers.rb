class AddProgressionToUserAnswers < ActiveRecord::Migration[8.0]
  def change
    add_reference :user_answers, :progression, foreign_key: true
  end
end
