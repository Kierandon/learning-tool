class CreateLearningObjectiveSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :learning_objective_steps do |t|
      t.references :learning_objective, null: false, foreign_key: true
      t.references :step, null: false, foreign_key: true

      t.timestamps
    end
  end
end
