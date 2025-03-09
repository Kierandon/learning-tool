class AddStandardReferenceToCourses < ActiveRecord::Migration[8.0]
  def change
    add_reference :courses, :standard, foreign_key: true, null: true
  end
end
