class CreateStandardCertificates < ActiveRecord::Migration[8.0]
  def change
    create_table :standard_certificates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :standard, null: false, foreign_key: true
      t.date :issue_date, null: false
      t.string :certificate_number, null: false
      t.string :competency_level
      t.timestamps

      t.index [ :user_id, :standard_id ], unique: true
    end
  end
end
