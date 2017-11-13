class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|

      t.string :stripe_charge_id
      t.float :amount

      t.timestamps
    end
    add_reference :charges, :user, foreign_key: true
  end
end
