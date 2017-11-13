class CreateDeposits < ActiveRecord::Migration[5.1]
  def change
    create_table :deposit_information do |t|

      t.string :paypal
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country

      t.timestamps
    end
    add_reference :deposit_information, :user, foreign_key: true
  end
end
