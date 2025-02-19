class AddMatchingStyleToMatchingQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :matching_questions, :matching_style, :string, default: 'dropdown'
  end
end
