class CreateLearningObjectiveAssociatedSections < ActiveRecord::Migration[8.0]
  def change
    create_table :learning_objective_associated_sections do |t|
      t.references :learning_objective, null: false, foreign_key: true
      t.references :standard_section, null: false, foreign_key: true
      t.timestamps
    end
  end
end
