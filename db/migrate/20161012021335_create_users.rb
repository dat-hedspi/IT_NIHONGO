class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :feelings
      t.boolean :is_admin, default: false
      t.string :provider
      t.string :uid

      t.timestamps null: false
    end
    add_index :users, unique: true
  end
end
