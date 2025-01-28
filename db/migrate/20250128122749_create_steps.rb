class CreateSteps < ActiveRecord::Migration[8.0]
  def change
    create_table :steps do |t|
      t.references :course, null: false, foreign_key: true
      t.string :title
      t.string :step_type
      t.text :content
      t.integer :position

      t.timestamps
    end
  end
end
