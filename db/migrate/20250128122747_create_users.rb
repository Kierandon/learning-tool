class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :login_hash, null: false
      t.string :type, null: false, default: "User"

      t.timestamps
    end

    add_index :users, :login_hash, unique: true
  end
end
