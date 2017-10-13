class CreateReviewsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: true
      t.text :body

      t.timestamps null: false
    end
    add_reference :reviews, :people, foreign_key: true
  end
end
