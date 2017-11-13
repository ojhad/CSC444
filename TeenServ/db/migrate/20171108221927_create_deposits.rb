class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :payout_informations do |t|

      t.string :paypal
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country

      t.timestamps
    end
    add_reference :payout_informations, :user, foreign_key: true
  end
end
