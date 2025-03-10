class AddVisibilityFlagToStandards < ActiveRecord::Migration[8.0]
  def change
    add_column :standards, :visibility, :boolean, default: true, null: false
  end
end
