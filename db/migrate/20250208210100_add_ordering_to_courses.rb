class AddOrderingToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :ordering, :integer
  end
end
