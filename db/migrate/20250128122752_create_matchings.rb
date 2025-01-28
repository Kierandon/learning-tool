class CreateMatchings < ActiveRecord::Migration[8.0]
  def change
    create_table :matchings do |t|
      t.references :question, null: false, foreign_key: true
      t.string :item_type
      t.string :content
      t.integer :pair_id
      t.integer :position

      t.timestamps
    end
  end
end
