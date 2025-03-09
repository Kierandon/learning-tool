class CreateLearningObjectives < ActiveRecord::Migration[8.0]
  def change
    create_table :learning_objectives do |t|
      t.references :standard_section, null: false, foreign_key: true
      t.string :objective_id, null: false
      t.string :description, null: false
      t.string :completion_criteria

      t.timestamps
    end
  end
end
