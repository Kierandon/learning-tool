class CreateStandardSections < ActiveRecord::Migration[8.0]
  def change
    create_table :standard_sections do |t|
      t.references :standard, null: false, foreign_key: true
      t.references :parent_section, foreign_key: { to_table: :standard_sections }, null: true
      t.string :name, null: false
      t.string :section_id, null: false
      t.string :url
      t.date :published_on

      t.timestamps
    end

    add_index :standard_sections, [ :standard_id, :section_id ], unique: true
  end
end
