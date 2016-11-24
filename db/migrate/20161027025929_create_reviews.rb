class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.text :content
      t.decimal :rating
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps
    end
    add_index :reviews, [:rated, :created_at]
  end
end
