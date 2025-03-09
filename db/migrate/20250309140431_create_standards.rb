class CreateStandards < ActiveRecord::Migration[8.0]
  def change
    create_table :standards do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :url
      t.timestamps
    end

    add_index :standards, :code, unique: true
  end
end
