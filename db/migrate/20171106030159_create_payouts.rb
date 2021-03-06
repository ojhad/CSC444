class CreatePayouts < ActiveRecord::Migration[5.1]
  def change
    create_table :payouts do |t|

      t.float :amount
      t.string :batch_id
      t.timestamps
    end
    add_reference :payouts, :user, foreign_key: true
  end
end
